<table>
    <thead>
        <th>Intitule</th>
        <th>Auteur</th>
        <th>Date</th>
        <th>Actions</th>
    </thead>
    <?php if($actualites): ?>
    <tbody>
        <?php foreach($actualites as $actualite): ?>
        <tr>
            <td><?= $actualite['act_titre'] ?></td>
            <td><?= $actualite['cpt_pseudo'] ?></td>
            <td><?= $actualite['act_date'] ?></td>
            <td><a href="<?= url_to('actualite#afficher', $actualite['act_id']) ?>">Lire</a></td>
        </tr>
        <?php endforeach; ?>
    </tbody>
    <?php else: ?>
        <tbody>
            <tr>
                <td colspan='4'>Aucune actualites !</td>
            </tr>
        </tbody>
    <?php endif; ?>
</table>
<div style="height: 20vh; display: flex; flex-direction: row; align-items: center; justify-content: space-around;">
    <?php if($pages['current'] > 1): ?>
        <a href="<?= url_to("actualites#listing#page", $pages['current'] - 1) ?>">Page précédente</a>
    <?php endif; ?>
    <?php if($pages['current'] < $pages['max']): ?>
        <a href="<?= url_to("actualites#listing#page", $pages['current'] + 1) ?>">Page suivante</a>
    <?php endif; ?>
</div>