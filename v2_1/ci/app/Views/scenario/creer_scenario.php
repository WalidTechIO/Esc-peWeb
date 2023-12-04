<?= session()->getFlashdata('error') ?>

<?= form_open_multipart(url_to("scenario#creer")) ?>
    <?= csrf_field() ?>

    <label for="intitule">Intitulé du scénario : </label>
    <input type="text" name="intitule">
    <?= validation_show_error('intitule') ?>

    <label for="statut">Statut : </label>
    <select name="statut">
        <option value="P">Publié</option>
        <option value="C">Caché</option>
    </select>
    <?= validation_show_error('statut') ?>

    <label for="prenom">Image du scénario : </label>
    <input type="file" name="image">
    <?= validation_show_error('image') ?>

    <div>
        <input style="margin-top: 2em;" type="submit" value="Créer !"/>
    </div>
</form>