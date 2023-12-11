<?php $nomNiveau = ['Facile', 'Moyen', 'Difficile']; ?>

<h1>Féliciations !<br> Vous avez terminé le scénario "<?= $scenario['sce_intitule'] ?>" dans la difficulté <?= $nomNiveau[$niveau - 1] ?> !</h1>
<p>Entrez votre adresse e-mail ci-dessous pour enregistrer votre reussite</p>
<?= form_open(url_to('scenario#reussite', $controlKey)) ?>
    <input type="email" name="email" placeholder="Votre adresse e-mail"/>
    <?= validation_show_error('email') ?>
    <div>
        <input style="margin-top: 2em;" type="submit" value="Enregistrer !"/>
    </div>
</form>