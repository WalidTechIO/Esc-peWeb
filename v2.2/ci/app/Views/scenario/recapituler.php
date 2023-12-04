<button style="margin-bottom: 1em;">
    <a style="border-bottom: none;" href="<?= url_to("scenario#creer") ?>">
        <img style="margin-right: 1em;" color="white" height="25%" src="<?= base_url() ?>images/plus.svg" alt="+"/>
        Ajouter un scénario
    </a>
</button>
<?= "<br>".session()->getFlashdata('error') ?>
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
                <a target="blank" href="<?= url_to('scenario#detail', $scenario['sce_code']) ?>"><img width="18em" src="<?= base_url() . "images/see.svg" ?>" alt="Visualiser" title="Visualiser"/></a>
                <?php if($scenario['cpt_pseudo'] == session()->get('user')['pseudo']): ?>
                    <a href="#"><img width="18em" src="<?= base_url() . "images/edit.svg" ?>" alt="Modifier" title="Modifier"/></a>
                    <a href="#"><img width="18em" src="<?= base_url() . "images/reset.svg" ?>" alt="Remise à zéro" title="Remise à zéro"/></a>
                    <a href="<?= url_to('scenario#supprimer', $scenario['sce_code']) ?>"><img width="18em" src="<?= base_url() . "images/delete.svg" ?>" alt="Supprimer" title="Supprimer"/></a>
                <?php else: ?>
                    <a href="#"><img width="18em" src="<?= base_url() . "images/copy.svg" ?>" alt="Copier" title="Copier"/></a>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>