<nav id="menu">
	<div class="inner">
	    <h2>Menu</h2>
		<ul class="links">
			<!-- Items généraux -->

			<?php if(session()->get('user') && session()->get('user')['role'] == 'A'): ?> 
				<!-- Item admin -->
				<li><a href="<?= url_to("compte#lister") ?>">Comptes</a></li>
			<?php endif; ?>

			<?php if(session()->get('user') && session()->get('user')['role'] == 'O'): ?> 
				<!-- Item organisateur -->
				<li><a href="<?= url_to("scenario#recapitulatif") ?>">Récapitulatif des scenariis</a></li>
			<?php endif; ?>

			<?php if(!session()->get('user')): ?> 
				<!-- Item non connecté -->
				<li><a href="<?= base_url() ?>">Acceuil</a></li>
				<li><a href="<?= url_to("scenarii#afficher") ?>">Jouer</a></li>
				<li><a href="<?= url_to("compte#connecter") ?>">Se connecter</a></li>
			<?php else: ?> 
				<!-- Item connecté -->
				<li><a href="<?= url_to("compte#afficher_profil") ?>">Mon profil</a></li>
				<li><a href="<?= url_to("compte#deconnecter") ?>">Se déconnecter</a></li>
			<?php endif; ?>
		</ul>
		<a href="#" class="close">Fermer</a>
	</div>
</nav>