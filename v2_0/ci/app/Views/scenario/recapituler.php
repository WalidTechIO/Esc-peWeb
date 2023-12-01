<table>
    <thead>
        <th>Intitule</th>
        <th>Auteur</th>
        <th>Actions</th>
    </thead>
    <tbody>
        <?php foreach($scenarii as $scenario): ?>
        <tr>
            <td><?= $scenario['sce_intitule'] ?></td>
            <td><?= $scenario['cpt_pseudo'] ?></td>
            <td>
                <?php if($scenario['cpt_pseudo'] == session()->get('user')['pseudo']): ?>
                    M'appartient
                <?php else: ?>
                    Ne m'appartient pas
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>