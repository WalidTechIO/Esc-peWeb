<h3><?= $titre ?></h3>
<?php if(!empty($logins) && is_array($logins)): ?>
    <?php foreach($logins as $login): ?>
        <br/>--<?= $login['cpt_pseudo'] ?>--<br/>
    <?php endforeach; ?>
<?php endif; ?>