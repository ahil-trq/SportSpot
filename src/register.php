<?php
declare(strict_types=1);
require_once __DIR__ . '/includes/session.php';
require_once __DIR__ . '/includes/helpers.php';
require_once __DIR__ . '/includes/database.php';
require_once __DIR__ . '/includes/csrf.php';

$errors = [];
$values = array_fill_keys(['first_name', 'last_name', 'street', 'postal_code', 'city', 'email'], '');
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    verify_csrf();
    foreach ($values as $field => $_) {
        $values[$field] = trim((string) ($_POST[$field] ?? ''));
    }
    $password = (string) ($_POST['password'] ?? '');
    $password_confirmation = (string) ($_POST['password_confirmation'] ?? '');
    foreach (['first_name' => 'Vorname', 'last_name' => 'Nachname', 'street' => 'Straße und Hausnummer', 'postal_code' => 'Postleitzahl', 'city' => 'Ort', 'email' => 'E-Mail-Adresse'] as $field => $label) {
        if ($values[$field] === '') {
            $errors[] = $label . ' ist erforderlich.';
        }
    }
    if (!filter_var($values['email'], FILTER_VALIDATE_EMAIL)) $errors[] = 'Bitte geben Sie eine gültige E-Mail-Adresse ein.';
    if (strlen($password) < 8) $errors[] = 'Das Passwort muss mindestens 8 Zeichen lang sein.';
    if ($password !== $password_confirmation) $errors[] = 'Die Passwörter stimmen nicht überein.';
    if (!$errors) {
        try {
            $statement = db()->prepare('INSERT INTO users (first_name, last_name, street, postal_code, city, email, password_hash) VALUES (?, ?, ?, ?, ?, ?, ?)');
            $statement->execute([...array_values($values), password_hash($password, PASSWORD_DEFAULT)]);
            flash('success', 'Registrierung erfolgreich. Sie können sich jetzt anmelden.');
            redirect('login.php');
        } catch (PDOException $exception) {
            if ((int) $exception->errorInfo[1] === 1062) $errors[] = 'Diese E-Mail-Adresse ist bereits registriert.';
            else $errors[] = 'Die Registrierung konnte nicht gespeichert werden.';
        }
    }
}
$page_title = 'Registrieren';
require __DIR__ . '/includes/header.php';
?><h1 class="mb-4">Konto erstellen</h1>
<?php if ($errors): ?><div class="alert alert-danger"><ul class="mb-0"><?php foreach ($errors as $error): ?><li><?= e($error) ?></li><?php endforeach; ?></ul></div><?php endif; ?>
<form method="post" class="form-panel row g-3" novalidate>
    <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
    <?php foreach (['first_name' => 'Vorname', 'last_name' => 'Nachname', 'street' => 'Straße und Hausnummer', 'postal_code' => 'Postleitzahl', 'city' => 'Ort', 'email' => 'E-Mail-Adresse'] as $field => $label): ?><div class="col-md-6"><label class="form-label" for="<?= e($field) ?>"><?= e($label) ?></label><input class="form-control" id="<?= e($field) ?>" name="<?= e($field) ?>" value="<?= e($values[$field]) ?>" required <?= $field === 'email' ? 'type="email"' : '' ?>></div><?php endforeach; ?>
    <div class="col-md-6"><label class="form-label" for="password">Passwort</label><input class="form-control" id="password" name="password" type="password" minlength="8" required></div>
    <div class="col-md-6"><label class="form-label" for="password_confirmation">Passwort bestätigen</label><input class="form-control" id="password_confirmation" name="password_confirmation" type="password" minlength="8" required></div>
    <div class="col-12"><button class="btn btn-primary" type="submit">Konto erstellen</button></div>
</form>
<?php require __DIR__ . '/includes/footer.php';