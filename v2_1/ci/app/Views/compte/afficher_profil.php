<h1>Bonjour, <?= $user['cpt_pseudo'] ?></h1>
<p>
Nom: <?= $user['cpt_nom'] ?>
<br/>
Prénom: <?= $user['cpt_prenom'] ?>
<br/>
Adresse e-mail: <?= $user['cpt_mail'] ?>
<br/>
Statut: <?= ($user['cpt_role'] == "A") ? "Administrateur" : "Organisateur" ?>
</p>
<button><a href="<?= url_to("compte#profil") ?>">Modifier mon profil !</a></button>