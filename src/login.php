<?php
declare(strict_types=1);
require_once __DIR__ . '/includes/session.php';
require_once __DIR__ . '/includes/helpers.php';
require_once __DIR__ . '/includes/database.php';
require_once __DIR__ . '/includes/csrf.php';
$error = null;
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    verify_csrf();
    $email = trim((string) ($_POST['email'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');
    $statement = db()->prepare('SELECT * FROM users WHERE email = ?');
    $statement->execute([$email]);
    $user = $statement->fetch();
    if ($user && password_verify($password, $user['password_hash'])) {
        session_regenerate_id(true);
        unset($user['password_hash']);
        $_SESSION['user'] = $user;
        redirect('booking-step-1.php');
    }
    $error = 'E-Mail-Adresse oder Passwort ist nicht korrekt.';
}
$page_title = 'Anmelden';
require __DIR__ . '/includes/header.php';
?><h1 class="mb-4">Anmelden</h1>
<?php if ($error): ?><div class="alert alert-danger"><?= e($error) ?></div><?php endif; ?>
<form method="post" class="form-panel col-lg-6" novalidate><input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>"><div class="mb-3"><label class="form-label" for="email">E-Mail-Adresse</label><input class="form-control" id="email" name="email" type="email" required></div><div class="mb-3"><label class="form-label" for="password">Passwort</label><input class="form-control" id="password" name="password" type="password" required></div><button class="btn btn-primary" type="submit">Anmelden</button></form>
<?php require __DIR__ . '/includes/footer.php';