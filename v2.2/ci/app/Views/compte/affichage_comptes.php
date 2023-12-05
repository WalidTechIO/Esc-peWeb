<button style="margin-bottom: 1em;">
    <a style="border-bottom: none;" href="<?= url_to('compte#creer') ?>">
        <img style="margin-right: 1em;" color="white" height="25%" src="<?= base_url() ?>images/plus.svg" alt="+"/>
        Ajouter un compte
    </a>
</button>
<h3><?= $title ?></h3>
<table>
    <thead>
        <th>Email</th>
        <th>Pseudo</th>
        <th>Prénom</th>
        <th>Nom</th>
        <th>Statut</th>
        <th>Rôle</th>
        <th>Action</th>
    </thead>
    <?php if($comptes && is_array($comptes)): ?>
    <tbody>
        <?php foreach($comptes as $compte): ?>
        <tr>
            <td><?= $compte['cpt_mail'] ?></td>
            <td><?= $compte['cpt_pseudo'] ?></td>
            <td><?= $compte['cpt_prenom'] ?></td>
            <td><?= $compte['cpt_nom'] ?></td>
            <td><?= $compte['cpt_statut'] == 'A' ? "Activé" : "Désactivé" ?></td>
            <td><?= $compte['cpt_role'] == 'A' ? "Administrateur" : "Organisateur" ?></td>
            <td><a style="border-bottom: none;" href="#"><img src="<?= base_url() . "/images/edit.svg" ?>" width="18em"/></a></td>
        </tr>
        <?php endforeach; ?>
    </tbody>
    <?php else: ?>
        <tbody>
            <tr>
                <td colspan='7'>Aucun compte !</td>
            </tr>
        </tbody>
    <?php endif; ?>
</table>