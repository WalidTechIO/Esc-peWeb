<h3><?= $title ?></h3>

<?= session()->getFlashdata('error') ?>

<?= form_open(url_to("compte#creer")) ?>
    <?= csrf_field() ?>

    <label for="prenom">Prénom : </label>
    <input type="text" name="prenom">
    <?= validation_show_error('prenom') ?>

    <label for="nom">Nom : </label>
    <input type="text" name="nom">
    <?= validation_show_error('nom') ?>

    <label for="pseudo">Pseudo : </label>
    <input type="text" name="pseudo">
    <?= validation_show_error('pseudo') ?>

    <label for="email">Adresse e-mail : </label>
    <input type="email" name="email">
    <?= validation_show_error('email') ?>

    <label for="mdp">Mot de passe : </label>
    <input type="password" name="mdp">
    <?= validation_show_error('mdp') ?>

    <label for="mdp_conf">Confirmation du mot de passe : </label>
    <input type="password" name="mdp_conf">
    <?= validation_show_error('mdp_conf') ?>

    <label for="statut">Statut : </label>
    <select name="statut">
        <option value="A">Activé</option>
        <option value="D">Désactivé</option>
    </select>
    <?= validation_show_error('statut') ?>

    <label for="role">Role : </label>
    <select name="role">
        <option value="A">Administrateur</option>
        <option value="O">Organisateur</option>
    </select>
    <?= validation_show_error('role') ?>

    <div>
        <input style="margin-top: 2em;" type="submit" value="Inscrire !"/>
    </div>
</form>