#!/bin/bash

echo "=== COMPILATION COMPLÈTE FORCÉE ==="

# Nettoyage complet
rm -f main.aux main.bbl main.blg main.out main.log main.toc
echo "✓ Cache nettoyé"

# Séquence complète LaTeX + BibTeX + LaTeX + LaTeX
echo "1. Première compilation LaTeX..."
pdflatex main.tex > /dev/null 2>&1
echo "✓ LaTeX 1 terminé"

echo "2. Compilation BibTeX..."
bibtex main
echo "✓ BibTeX terminé"

echo "3. Deuxième compilation LaTeX..."
pdflatex main.tex > /dev/null 2>&1
echo "✓ LaTeX 2 terminé"

echo "4. Compilation finale LaTeX..."
pdflatex main.tex > /dev/null 2>&1
echo "✓ LaTeX final terminé"

# Vérification
if [ -f main.pdf ]; then
    SIZE=$(du -h main.pdf | cut -f1)
    echo "=== RÉSULTAT ==="
    echo "✅ PDF généré: main.pdf ($SIZE)"
    ls -la main.pdf
else
    echo "❌ Erreur: PDF non généré"
    exit 1
fi