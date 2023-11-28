<h3><?= $title ?></h3>

<?= session()->getFlashdata('error') ?>
<?= session()->getFlashdata('success') ?>

<?= form_open(url_to("compte#profil")) ?>
    <?= csrf_field() ?>

    <label for="nom">Nom : </label>
    <input type="text" name="nom" value="<?= $compte['cpt_nom'] ?? '' ?>" >
    <?= validation_show_error('nom') ?>

    <label for="prenom">Prenom : </label>
    <input type="text" name="prenom" value="<?= $compte['cpt_prenom'] ?? '' ?>" >
    <?= validation_show_error('prenom') ?>

    <label for="mail">Adresse e-mail : </label>
    <input type="email" name="mail" value="<?= $compte['cpt_mail'] ?? '' ?>" >
    <?= validation_show_error('mail') ?>

    <label for="mdp">Nouveau mot de passe : </label>
    <input type="password" name="mdp" placeholder="•••••••••••••" >
    <?= validation_show_error('mdp') ?>

    <label for="mdp_conf">Confirmation du nouveau mot de passe : </label>
    <input type="password" name="mdp_conf" placeholder="•••••••••••••" >
    <?= validation_show_error('mdp_conf') ?>

    <label for="mdp_last">Mot de passe actuel : </label>
    <input type="password" name="mdp_last" placeholder="•••••••••••••" >
    <?= validation_show_error('mdp_last') ?>

    <div>
        <input style="margin-top: 2em;" type="submit" value="Confirmer !"/>
    </div>

</form>