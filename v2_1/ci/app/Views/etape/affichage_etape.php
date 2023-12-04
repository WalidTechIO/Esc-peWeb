<?php if($etape['eta_question']): ?>
<p>
    <?= $etape['eta_question'] ?>
    <br>
</p>
    <?= form_open("") ?>
        <input type="text" placeholder="Réponse"/>
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