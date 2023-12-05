<div style="display: flex; gap: 5em;">
    <img width="80em" height="80em" src="<?= base_url() . $scenario['res_chemin'] ?>" alt="">
    <div>
        <h3><?= $scenario['sce_intitule'] ?></h3>
        <p style="font-size: 0.75em">
            Statut: <?= ($scenario['sce_statut'] == 'P') ? "Publié" : "Caché" ?><br>
            Code: <?= $scenario['sce_code'] ?><br>
            Auteur: <?= $scenario['cpt_pseudo'] ?>
        </p>
    </div>
</div>
<h1>Liste des etapes: </h1>
<?php if($scenario['etapes']): ?>
    <table>
        <thead>
            <th>Question</th>
            <th>Réponse</th>
        </thead>
        <tbody>
            <?php foreach($scenario['etapes'] as $etape): ?>
                <tr>
                    <td><?= $etape['eta_question'] ?></td>
                    <td><?= htmlentities($etape['eta_reponse']) ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
<?php else: ?>
    <p>Aucune étape !</p>
<?php endif; ?>