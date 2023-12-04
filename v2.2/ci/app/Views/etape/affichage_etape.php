<?php if($etape['eta_question']): ?>
<p>
    <?= $etape['eta_question'] ?>
    <br>
</p>
    <?= form_open($action) ?>
        <?= csrf_field() ?>
        <?= validation_show_error('hide') ?>
        <br>
        <?= validation_show_error('reponse') ?>
        <br>
        <?= session()->getFlashdata('error') ?>
        <?= session()->getFlashdata('success') ?>
        <input type="hidden" name="hide" value="<?= $etape['sce_intitule'].$etape['eta_code'].$niveau ?>">
        <input name="reponse" type="text" placeholder="Réponse"/>
        <?php if($etape['ind_id']): ?>
            <a style="margin-right: 7px;" target="blank" title="<?= $etape['ind_texte'] ?>" href="<?= $etape['ind_lien'] ?>">Indice</a>
        <?php endif; ?>
        <br>
        <div style="display: flex; flex-direction: column; align-items: center;">
            <input style="width: 50%" type="submit" value="Soumettre la réponse">
        </div>
    </form>
<?php else: ?>
    <h1>Aucune étape associée pour le moment</h1>
<?php endif; ?>