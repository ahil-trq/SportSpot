<?php
declare(strict_types=1);
require_once __DIR__ . '/session.php';
require_once __DIR__ . '/helpers.php';
require_once __DIR__ . '/auth.php';
$page_title = $page_title ?? 'SportSpot';
$flash_message = take_flash();
?><!doctype html>
<html lang="de">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= e($page_title) ?> | SportSpot</title>
    <link rel="icon" href="assets/img/sportspot-favicon.svg" type="image/svg+xml">
    <link rel="stylesheet" href="assets/vendor/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<header class="site-header">
    <nav class="navbar navbar-expand-lg" aria-label="Hauptnavigation">
        <div class="container">
            <a class="navbar-brand" href="index.php"><img src="assets/img/sportspot-logo.svg" alt="SportSpot Startseite"></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#main-nav" aria-controls="main-nav" aria-label="Navigation öffnen"><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="main-nav">
                <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-2">
                    <li class="nav-item"><a class="nav-link" href="booking-step-1.php">Buchen</a></li>
                    <?php if (current_user()): ?>
                        <li class="nav-item"><a class="nav-link" href="my-bookings.php">Meine Buchungen</a></li>
                        <li class="nav-item"><a class="btn btn-outline-light" href="logout.php">Abmelden</a></li>
                    <?php else: ?>
                        <li class="nav-item"><a class="nav-link" href="login.php">Anmelden</a></li>
                        <li class="nav-item"><a class="btn btn-primary" href="register.php">Registrieren</a></li>
                    <?php endif; ?>
                </ul>
            </div>
        </div>
    </nav>
</header>
<main class="container py-4">
<?php if ($flash_message): ?><div class="alert alert-<?= e($flash_message['type']) ?>" role="alert"><?= e($flash_message['message']) ?></div><?php endif; ?>