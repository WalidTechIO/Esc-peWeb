<?php if(isset($news)): ?>
    <h1><?= $news['act_titre'] ?></h1>
    <p><?= $news['act_contenu'] ?></p>
    Publié par <?= $news['cpt_pseudo'] ?> le <?= (new DateTime($news['act_date']))->format("d/m/Y à H\hm") ?>
<?php else: ?>
    <h4>Pas d'actualité !</h4>
<?php endif; ?>
