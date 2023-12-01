<?php if(session()->get('user')['role'] == "A"): ?>
    <h2>Espace d'administration</h2>
<?php else: ?>
    <h2>Espace organisateur</h2>
<?php endif; ?>
<br/>
<h3 style="border-bottom: none;">Session ouverte ! Bienvenue <?= session()->get('user')['pseudo'] ?> !</h3>