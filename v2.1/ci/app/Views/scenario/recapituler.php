<button style="margin-bottom: 1em;">
    <a style="border-bottom: none;" href="">
        <img style="margin-right: 1em;" color="white" height="25%" src="<?= base_url() ?>images/plus.svg" alt="+"/>
        Ajouter un scénario
    </a>
</button>
<table>
    <thead>
        <th>Intitule</th>
        <th>Code</th>
        <th>Statut</th>
        <th>Nombre d'étapes actives</th>
        <th>Auteur</th>
        <th>Actions</th>
    </thead>
    <tbody>
        <?php foreach($scenarii as $scenario): ?>
        <tr>
            <td><?= $scenario['sce_intitule'] ?></td>
            <td><?= $scenario['sce_code'] ?></td>
            <td><?= $scenario['sce_statut'] == 'P' ? "Publié" : "Caché" ?></td>
            <td><?= $scenario['nb_etapes'] ?></td>
            <td><?= $scenario['cpt_pseudo'] ?></td>
            <td>
                <a href="#"><img width="18em" src="<?= base_url() . "images/see.svg" ?>" alt="Visualiser"/></a>
                <?php if($scenario['cpt_pseudo'] == session()->get('user')['pseudo']): ?>
                    <a href="#"><img width="18em" src="<?= base_url() . "images/edit.svg" ?>" alt="Modifier"/></a>
                    <a href="#"><img width="18em" src="<?= base_url() . "images/delete.svg" ?>" alt="Supprimer"/></a>
                <?php else: ?>
                    <a href="#"><img width="18em" src="<?= base_url() . "images/copy.svg" ?>" alt="Copier"/></a>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>