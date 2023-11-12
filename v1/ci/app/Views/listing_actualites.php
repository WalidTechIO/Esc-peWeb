<table>
    <thead>
        <th>ID</th>
        <th>Intitule</th>
        <th>Date</th>
        <th>Actions</th>
    </thead>
    <?php if($actualites): ?>
    <tbody>
        <?php foreach($actualites as $actualite): ?>
        <tr>
            <td><?= $actualite['act_id'] ?></td>
            <td><?= $actualite['act_titre'] ?></td>
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