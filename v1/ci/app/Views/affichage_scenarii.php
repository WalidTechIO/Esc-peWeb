<div class="inner">
    <div margin="0.5em;" style="width: 100%; height: 100%; display: flex; flex-direction: row; flex-wrap: wrap; justify-content: space-between;">
    <?php if($scenarii): ?>
        <?php foreach($scenarii as $scenario): ?>
            <div style="margin-top: 5vh; width: 22%; display: flex; align-items: center; flex-direction: column; border: 1px white solid; border-radius: 10px;">
                <img style="margin-top: 2vh; margin-bottom: 2vh;" height="100px;" src="<?= base_url() . $scenario['res_chemin'] ?>" alt="Image scenario"/>
                <h3><?= $scenario["sce_intitule"] ?></h3>
                <h4>Par <?= $scenario["cpt_pseudo"] ?></h4>
                <p>Niveau</p>
                <ul style="list-style-type: none; display: flex; flex-direction: row; justify-content: space-around; width: 60%; padding-left: 0;">
                    <?php for($i = 1; $i < 3+1; $i++): ?>
                        <li style="padding: 0;"><a href="<?= url_to("scenario#premiere_etape", $scenario["sce_code"], $i) ?>"><?= $i ?></a></li>
                    <?php endfor; ?>
                </ul>
            </div>
        <?php endforeach; ?>
    <?php else: ?>
        <h1>Aucun scénario !</h1>
    <?php endif; ?>
    </div>
</div>