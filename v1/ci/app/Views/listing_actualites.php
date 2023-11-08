<div class="inner">
    <table>
        <thead>
            <th>ID</th>
            <th>Intitule</th>
            <th>Date</th>
        </thead>
        <?php if($actualites): ?>
        <tbody>
            <?php foreach($actualites as $actualite): ?>
            <tr>
                <td><?= $actualite['act_id'] ?></td>
                <td><?= $actualite['act_titre'] ?></td>
                <td><?= $actualite['act_date'] ?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
        <?php else: ?>
            <tbody><tr><td colspan='3'>Aucune actualites !</td></tr></tbody>
        <?php endif; ?>
    </table>
</div>