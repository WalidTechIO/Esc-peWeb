<p>
    <?= $etape['eta_question'] ?>
    <br>
</p>
<input type="text" placeholder="Réponse"/>
<?php if($etape['indice']): ?>
    <a style="margin-right: 7px;" target="blank" title="<?= $etape['indice']['ind_texte'] ?>" href="<?= $etape['indice']['ind_lien'] ?>">Indice</a>
<?php endif; ?>
<?php if($etape['res_id']): ?>
    <a style="" target="blank" href="<?= base_url() . $etape['res_chemin'] ?>">Visualiser la ressource</a>
 <?php endif; ?>
<br>
<div style="display: flex; flex-direction: column; align-items: center;">
    <input style="width: 50%" type="submit" value="Soumettre la réponse">
</div>