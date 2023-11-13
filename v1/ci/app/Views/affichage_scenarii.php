<div class="inner">
    <div margin="0.5em;" style="width: 100%; height: 100%; display: flex; flex-direction: row; flex-wrap: wrap;">
    <?php foreach($scenarii as $scenario): ?>
        <div style="width: 25%; height: 100vh;">
            <img height="100px;" src="<?= base_url() . $scenario['res_chemin'] ?>" alt="Image scenario"/>
            <h3><?= $scenario["sce_intitule"] ?></h3>
            <h4><?= $scenario["sce_code"] ?></h4>
            <p>Niveau</p>
                <ul style="list-style-type: none; display: flex; flex-direction: row; justify-content: space-between; width: 70%;">
                    <li><a href="<?= url_to("scenarii#premiere_etape", $scenario["sce_code"], 1) ?>">1</a></li>
                    <li><a href="<?= url_to("scenarii#premiere_etape", $scenario["sce_code"], 2) ?>">2</a></li>
                    <li><a href="<?= url_to("scenarii#premiere_etape", $scenario["sce_code"], 3) ?>">3</a></li>
                </ul>
        </div>
    <?php endforeach; ?>
    </div>
</div>