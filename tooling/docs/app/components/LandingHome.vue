<template>
  <main class="landing-home">
    <section class="landing-hero">
      <div class="landing-shell landing-hero__content">
        <img
          class="landing-hero__brand"
          src="/logo-sciance.svg"
          alt="Sciance"
        >
        <p class="landing-eyebrow">
          Documentation du Store Snowflake
        </p>
        <h1>Store Snowflake</h1>
        <p class="landing-hero__lead">
          Un guide de travail pour construire, versionner et maintenir des tableaux de bord de formation professionnelle avec <em>Snowflake</em> et <em>dbt</em>.
        </p>

        <div class="landing-actions" aria-label="Actions principales">
          <a class="landing-button landing-button--primary" href="/fr/01-demarrage/01-presentation">
            Ouvrir la documentation
          </a>
          <a class="landing-button landing-button--secondary" href="/fr/04-installation/01-wsl2">
            Configurer la machine
          </a>
        </div>
      </div>
    </section>

    <section class="landing-section">
      <div class="landing-shell">
        <div class="landing-section__header">
          <p class="landing-eyebrow">
            Commencer
          </p>
          <h2>Le chemin le plus simple</h2>
          <p>
            Le site suit l'ordre réel du travail : comprendre le projet, préparer la machine, configurer <em>Snowflake</em>, puis exécuter <em>dbt</em> depuis le dépôt local.
          </p>
        </div>

        <div class="landing-card-grid">
          <a class="landing-card" href="/fr/01-demarrage/01-presentation">
            <span class="landing-card__index">01</span>
            <h3>Comprendre le projet</h3>
            <p>Voir le rôle du core, du dépôt local et du projet FP.</p>
          </a>
          <a class="landing-card" href="/fr/04-installation/01-wsl2">
            <span class="landing-card__index">02</span>
            <h3>Préparer le poste</h3>
            <p>Installer WSL2, Python, Poetry et le profil dbt.</p>
          </a>
          <a class="landing-card" href="/fr/04-installation/09-snowflake-environnements">
            <span class="landing-card__index">03</span>
            <h3>Configurer Snowflake</h3>
            <p>Créer les environnements, les rôles et les accès.</p>
          </a>
          <a class="landing-card" href="/fr/03-le-comptoir/01-architecture/07-overriding">
            <span class="landing-card__index">04</span>
            <h3>Adapter localement</h3>
            <p>Utiliser les overrides, les seeds et les adapters.</p>
          </a>
        </div>
      </div>
    </section>

    <section class="landing-section landing-section--quiet">
      <div class="landing-shell landing-split">
        <div class="landing-section__header">
          <p class="landing-eyebrow">
            Contenu
          </p>
          <h2>Ce que la documentation couvre</h2>
          <p>
            Les pages sont écrites pour aider une équipe analytique ou TI à poser les bons fichiers au bon endroit et à valider le résultat.
          </p>
        </div>

        <div class="landing-list">
          <a href="/fr/02-dbt/01-presentation-dbt">dbt, profils, commandes, seeds, modèles et tests</a>
          <a href="/fr/03-le-comptoir/01-architecture/02-deux-repos-et-responsabilites">Deux dépôts, responsabilités et logique d'héritage</a>
          <a href="/fr/04-installation/12-snowflake-authentification-et-profils-dbt">Connexion Snowflake par paire de clés ou SSO</a>
          <a href="/fr/03-le-comptoir/03-creer-tableau-de-bord/01-partir-du-gabarit">Gabarit Power BI, stamper et déploiement</a>
          <a href="/fr/07-comment-contribuer/02-faire-une-pull-request">Contribution par Pull Request et revue</a>
          <a href="/fr/08-aide-ia/01-se-faire-aider-par-une-ia">Aide AI avec llms.txt et MCP</a>
        </div>
      </div>
    </section>
  </main>
</template>

<style scoped>
.landing-home {
  --landing-accent: var(--color-sciance-blue);
  --landing-border: var(--ui-border);
  --landing-muted: var(--ui-text-muted);
  --landing-bg: var(--ui-bg);
  --landing-panel: var(--ui-bg-muted);
  --landing-ink: var(--ui-text-highlighted);
  color: var(--landing-ink);
  background: var(--landing-bg);
}

.landing-shell {
  width: min(1120px, calc(100% - 2rem));
  margin: 0 auto;
}

.landing-hero {
  position: relative;
  min-height: 68vh;
  overflow: hidden;
  display: flex;
  align-items: center;
  border-bottom: 1px solid var(--landing-border);
  background: var(--landing-bg);
}

.landing-hero__content {
  position: relative;
  padding: 5rem 0 4rem;
}

.landing-hero__brand {
  display: block;
  width: 15rem;
  max-width: 70vw;
  height: auto;
  margin-bottom: 2rem;
}

.landing-hero h1 {
  max-width: 760px;
  margin: 0;
  font-size: 4rem;
  line-height: 1;
  letter-spacing: 0;
}

.landing-hero__lead {
  max-width: 680px;
  margin: 1.25rem 0 0;
  color: var(--landing-muted);
  font-size: 1.25rem;
  line-height: 1.7;
}

.landing-eyebrow {
  margin: 0 0 1rem;
  color: var(--landing-accent);
  font-size: 0.875rem;
  font-weight: 700;
  letter-spacing: 0;
  text-transform: uppercase;
}

.landing-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
  margin-top: 2rem;
}

.landing-button {
  display: inline-flex;
  min-height: 2.75rem;
  align-items: center;
  justify-content: center;
  border-radius: 0.5rem;
  padding: 0.75rem 1rem;
  font-weight: 700;
  text-decoration: none;
}

.landing-button--primary {
  background: var(--landing-ink);
  color: var(--landing-bg);
}

.landing-button--secondary {
  border: 1px solid var(--landing-border);
  color: var(--landing-ink);
  background: var(--landing-bg);
}

.landing-button:hover {
  outline: 2px solid var(--landing-accent);
  outline-offset: 2px;
}

.landing-section {
  padding: 4.5rem 0;
}

.landing-section--quiet {
  border-top: 1px solid var(--landing-border);
  background: var(--landing-panel);
}

.landing-section__header {
  max-width: 720px;
}

.landing-section__header h2 {
  margin: 0;
  font-size: 2.25rem;
  line-height: 1.15;
  letter-spacing: 0;
}

.landing-section__header p {
  margin: 1rem 0 0;
  color: var(--landing-muted);
  font-size: 1.0625rem;
  line-height: 1.7;
}

.landing-card-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 1rem;
  margin-top: 2rem;
}

.landing-card {
  min-height: 13rem;
  border: 1px solid var(--landing-border);
  border-radius: 0.5rem;
  background: var(--landing-bg);
  padding: 1.25rem;
  text-decoration: none;
  color: inherit;
}

.landing-card:hover {
  border-color: var(--landing-accent);
}

.landing-card__index {
  color: var(--landing-accent);
  font-weight: 800;
}

.landing-card h3 {
  margin: 1rem 0 0;
  font-size: 1.125rem;
  line-height: 1.3;
}

.landing-card p {
  margin: 0.75rem 0 0;
  color: var(--landing-muted);
  line-height: 1.6;
}

.landing-split {
  display: grid;
  grid-template-columns: minmax(0, 0.9fr) minmax(0, 1.1fr);
  gap: 2rem;
  align-items: start;
}

.landing-list {
  display: grid;
  gap: 0.75rem;
}

.landing-list a {
  border: 1px solid var(--landing-border);
  border-radius: 0.5rem;
  background: var(--landing-bg);
  padding: 1rem;
  color: inherit;
  font-weight: 700;
  text-decoration: none;
}

.landing-list a:hover {
  border-color: var(--landing-accent);
}

@media (max-width: 900px) {
  .landing-hero h1 {
    font-size: 3rem;
  }

  .landing-card-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }

  .landing-split {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 560px) {
  .landing-hero {
    min-height: auto;
  }

  .landing-hero__content {
    padding: 4rem 0 3rem;
  }

  .landing-hero h1 {
    font-size: 2.5rem;
  }

  .landing-hero__brand {
    width: 12rem;
    margin-bottom: 1.5rem;
  }

  .landing-hero__lead {
    font-size: 1.0625rem;
  }

  .landing-button {
    width: 100%;
  }

  .landing-card-grid {
    grid-template-columns: 1fr;
  }
}
</style>
