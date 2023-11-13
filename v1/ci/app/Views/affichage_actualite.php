
<h3><?= $titre ?></h3>
<?php if(isset($news)): ?>
    <?= $news['act_id'] ?> -- <?= $news['act_titre'] ?>
<?php else: ?>
    <h4>Pas d'actualité !</h4>
<?php endif; ?>
