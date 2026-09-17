<?php
declare(strict_types=1);

function current_user(): ?array
{
    return $_SESSION['user'] ?? null;
}

function require_login(): void
{
    if (!current_user()) {
        flash('warning', 'Bitte loggen Sie sich zuerst ein.');
        redirect('login.php');
    }
}