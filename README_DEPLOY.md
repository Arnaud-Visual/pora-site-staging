# PORA — Pack site prêt à déployer (v2)

> Version 2 — post brief Nathan Bros (2026-04-22). Téléphone +33 7 61 10 97 50 **déjà intégré** partout. WhatsApp en canal principal.

## Contenu
- `index.html` / `services.html` / `tarifs.html` / `realisations.html` / `a-propos.html` / `contact.html`
- `mentions-legales.html` / `404.html`
- `sitemap.xml` · `robots.txt` · `.htaccess`
- `deploy.sh` — script FTP Hostinger
- `assets/`
  - `css/styles.css`
  - `js/main.js`
  - `logo/` — PNG + WebP (clair + sombre + 325px)
  - `favicon/` — pack complet (16, 32, 48, 180, 192, 512 + .ico + apple-touch)
  - `img/` — 3 hero IA optimisés WebP + JPG (desktop 1920 + mobile 800)

## À configurer AVANT déploiement

### 1. Hostinger FTP
Dans `deploy.sh`, remplacer :
```
FTP_USER="FTP_USER_TO_REPLACE"
FTP_PASS="FTP_PASS_TO_REPLACE"
```
par les credentials Hostinger (hPanel → Fichiers → Comptes FTP).

### 2. SIRET (quand Nathan l'aura)
Dans `mentions-legales.html`, remplacer `<em>à compléter (en cours)</em>` par le SIRET.

### 3. Formspree (form contact — backup WhatsApp)
1. Créer un compte sur https://formspree.io (free tier = 50 soumissions / mois)
2. Créer un nouveau formulaire "Contact PORA"
3. Récupérer l'ID (format `xyzabc12`)
4. Dans `contact.html`, remplacer `FORMSPREE_ID` par l'ID réel

> Note : le WhatsApp (+33 7 61 10 97 50) est le canal #1. Le form est un backup pour les gens qui préfèrent pas WhatsApp — donc Formspree free tier (50/mois) suffit largement.

### 4. Google Search Console (après mise en ligne)
1. Se connecter https://search.google.com/search-console
2. Ajouter la propriété `https://propreourienauto.fr`
3. Valider via balise HTML (à ajouter dans `<head>` de index.html) ou via DNS
4. Soumettre `https://propreourienauto.fr/sitemap.xml`

### 5. Google Business Profile (critique pour SEO local)
1. Créer la fiche sur https://business.google.com
2. Catégorie principale : **Service de nettoyage de voitures** (mobile)
3. Adresse : Cournonsec, 34660
4. Zone desservie : cocher le rayon 30 km (Cournonsec → Montpellier → Sète)
5. Horaires : Lun-Ven 9h-19h · Sam 9h-18h · Dim fermé
6. Téléphone : 07 61 10 97 50
7. Site : https://propreourienauto.fr
8. Photos : avatar PORA + 3 photos (voiture/intérieur/Nathan)

## Déploiement

```bash
# Première fois : tout envoyer
bash deploy.sh --all

# Mises à jour suivantes (sans les lourdes images)
bash deploy.sh

# Fichier unique
bash deploy.sh services.html
```

## Checklist post-deploy

- [ ] https://propreourienauto.fr charge et affiche le hero "Le nettoyage auto qui vient à toi"
- [ ] Navigation entre les 6 pages fonctionne
- [ ] Favicon visible dans l'onglet navigateur
- [ ] **Bouton WhatsApp flottant** en bas à droite s'ouvre vers Nathan
- [ ] **Bouton "Devis WhatsApp"** du header ouvre WhatsApp avec message pré-rempli
- [ ] Page /contact.html affiche bien le gros bloc vert WhatsApp
- [ ] Form contact (Formspree) envoie bien (tester une demande)
- [ ] Mobile (DevTools responsive 375px) : menu hamburger OK, CTAs plein largeur
- [ ] Lighthouse mobile > 90 (Performance, SEO, Accessibilité)
- [ ] sitemap.xml accessible : `/sitemap.xml`
- [ ] robots.txt accessible : `/robots.txt`
- [ ] 404 personnalisée : `/page-inexistante` → 404.html avec CTA WhatsApp
- [ ] HTTPS forcé (redirect HTTP → HTTPS via .htaccess)

## Contenu v2 — ce qui est mis en avant

### Page d'accueil
- H1 : "Le nettoyage auto qui vient à toi."
- Section "Comment ça marche" (4 étapes photos → devis → RDV → voiture propre)
- 3 formules : Rapide 60€ / Complet 90€ / Grande Remise à Niveau 130-150€
- Pitch Nathan 21 ans
- Offre lancement "3 voitures = -20 €"

### Page Services
- Intro matos honnête (shampouineuse, aspi, microfibres, brosses)
- 3 formules détaillées + options
- Section "Pourquoi pas d'extérieur ?" (assumé, promesse de transparence)
- Section pros (flotte, facture, flexibilité)

### Page Tarifs
- 3 tableaux : formules / options / zone / modalités
- Section "Ce qu'on fait PAS" (extérieur, céramique, phares, BTP lourd)
- Encart offre lancement

### Page À propos
- Histoire Nathan 1ère personne (tutoiement direct)
- 3 types d'offres autour (tunnel / detailing luxe / Nathan au milieu)
- 4 règles philosophie
- Matériel réel, équipe (Florian à venir, Arnaud support)
- Zone d'intervention + peurs/envies honnêtes

### Page Contact
- **Option 1 — WhatsApp mis en avant** (bloc vert grand format, 3 photos types)
- **Option 2 — Formulaire** backup
- **Option 3 — Téléphone** fallback
- Coordonnées complètes + zones + offre lancement

### Page Réalisations
- Placeholders honnêtes ("premières photos à venir")
- Incitation à être client de lancement (-15 € contre photos)

### Mentions légales
- Nathan Bros · micro-entreprise (en cours)
- RC Pro "souscription en cours"
- RGPD WhatsApp photos 30j

## Notes techniques

- Hero chargé en background-image CSS (WebP desktop 1920 + mobile 800)
- Logos en PNG transparent (pour header clair et footer sombre)
- Form contact : Formspree prioritaire + fallback mailto automatique
- **Liens WhatsApp** : tous pointent vers `wa.me/33761109750` avec message pré-rempli contextuel selon la page/formule
- Schema.org AutomotiveBusiness sur index.html (15 villes areaServed, 3 offers avec prix)
- Pas de JS de tracking tiers pour l'instant (Plausible/GA4 à ajouter post-lancement)
- Police Inter chargée depuis Google Fonts (preconnect + display=swap)
- Bouton WhatsApp flottant vert fixe en bas à droite (mobile + desktop)
