<?php
declare(strict_types=1);
require_once __DIR__ . '/database.php';

function slot_options(): array
{
    return ['09:00' => '10:00', '10:00' => '11:00', '11:00' => '12:00', '14:00' => '15:00', '15:00' => '16:00', '16:00' => '17:00', '17:00' => '18:00', '18:00' => '19:00'];
}

function booking_resources(array $filters = []): array
{
    $conditions = ['is_active = 1'];
    $parameters = [];
    if (!empty($filters['sport_type'])) { $conditions[] = 'sport_type = ?'; $parameters[] = $filters['sport_type']; }
    if (!empty($filters['area_type'])) { $conditions[] = 'area_type = ?'; $parameters[] = $filters['area_type']; }
    if (($filters['max_price'] ?? '') !== '' && is_numeric($filters['max_price'])) { $conditions[] = 'price_per_slot <= ?'; $parameters[] = (float) $filters['max_price']; }
    $statement = db()->prepare('SELECT * FROM resources WHERE ' . implode(' AND ', $conditions) . ' ORDER BY id');
    $statement->execute($parameters);
    return $statement->fetchAll();
}

function booking_extras(): array
{
    return db()->query('SELECT * FROM extras WHERE is_active = 1 ORDER BY id')->fetchAll();
}

function valid_date(string $date): bool
{
    $parsed = DateTimeImmutable::createFromFormat('!Y-m-d', $date);
    return $parsed && $parsed->format('Y-m-d') === $date && $parsed >= new DateTimeImmutable('today');
}

function occupied_slots(int $resource_id, string $date): array
{
    $statement = db()->prepare('SELECT start_time FROM bookings WHERE resource_id = ? AND booking_date = ? AND status = "confirmed"');
    $statement->execute([$resource_id, $date]);
    return array_map(static fn (array $row): string => substr($row['start_time'], 0, 5), $statement->fetchAll());
}

function calculate_booking(array $resource, array $extra_ids, string $coupon_code = '', int $slot_count = 1): array
{
    $slot_count = max(1, $slot_count);
    $selected_extras = [];
    $extras_total = 0.0;
    if ($extra_ids) {
        $placeholders = implode(',', array_fill(0, count($extra_ids), '?'));
        $statement = db()->prepare('SELECT * FROM extras WHERE is_active = 1 AND id IN (' . $placeholders . ')');
        $statement->execute($extra_ids);
        $selected_extras = $statement->fetchAll();
        foreach ($selected_extras as $extra) $extras_total += (float) $extra['price'];
    }
    $subtotal = ((float) $resource['price_per_slot'] * $slot_count) + $extras_total;
    $discount = 0.0;
    $coupon = null;
    if ($coupon_code !== '') {
        $statement = db()->prepare('SELECT * FROM coupons WHERE code = ? AND is_active = 1 AND valid_from <= CURRENT_DATE AND valid_until >= CURRENT_DATE');
        $statement->execute([strtoupper(trim($coupon_code))]);
        $coupon = $statement->fetch() ?: null;
        if ($coupon) $discount = $coupon['discount_type'] === 'percent' ? $subtotal * ((float) $coupon['discount_value'] / 100) : (float) $coupon['discount_value'];
    }
    $discount = min($subtotal, round($discount, 2));
    return ['extras' => $selected_extras, 'subtotal' => $subtotal, 'discount' => $discount, 'total' => $subtotal - $discount, 'coupon' => $coupon];
}