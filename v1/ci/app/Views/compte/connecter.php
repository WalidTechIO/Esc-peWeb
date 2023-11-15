<h3><?= $title ?></h3>

<?= session()->getFlashdata('error') ?>
<?= session()->getFlashdata('success') ?>

<?= form_open(url_to("compte#connecter")) ?>
    <?= csrf_field() ?>

    <label for="pseudo">Pseudo : </label>
    <input type="text" name="pseudo">
    <?= validation_show_error('pseudo') ?>

    <label for="mdp">Mot de passe : </label>
    <input type="password" name="mdp">
    <?= validation_show_error('mdp') ?>

    <div>
        <input style="margin-top: 2em;" type="submit" value="Inscrire !"/>
    </div>

</form>