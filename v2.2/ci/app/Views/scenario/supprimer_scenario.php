<?= session()->getFlashdata('error') ?>

<?= form_open(url_to("scenario#supprimer", $scenario['sce_code'])) ?>
    <?= csrf_field() ?>
    Êtes-vous sur de vouloir supprimer le scénario ?
    <br>
    <input type="submit" value="Supprimer" name="action"/>
    <input type="submit" value="Annuler" name="action"/>
</form>