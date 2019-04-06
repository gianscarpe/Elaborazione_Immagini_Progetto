/// EI_Progetto2018
Il progetto consiste nel generare la stringa FEN di alcuni schemi di scacchi della settimana enigmistica

// PREREQUISITI

- Matlab: questo progetto è stato sviluppato con Matlab R2017b ; non è garantita la compatibilità con versioni precedenti
- Matlab toolbox Compute Vision : essenziale per l'esecuzione 

// SETUP ED ESECUZIONE
- Copiare la chiave di deployment fornita (id_rsa) in ~/.ssh/
- Da terminale eseguire:
	- eval "$(ssh-agent -s)" : Avvia agente SSH
	- ssh-add ~/.ssh/id_rsa : Abilita la chiave di deployment
	- git clone git@gitlab.com:gianscarpe/EI_Progetto2018.git : Clonare il repositery in locale, con il relativo Dataset

- Recarsi nella cartella principale (da qui in poi root) del repositery. I file contenuti e l'albero delle directory è illustrato in seguito
- Aggiungere la cartelle root e tutte le sue sottocartelle al path (tramite AddPath -> Selected Folder and Subfolders)
- Recarsi nello script *Main.m*
- indicare il numero di immagine di test su cui eseguire lo script (i numeri delle immagini di test sono elencati in seguito)
- Eseguire lo script *Main.m*

// FILE E DIRECTORY
/ Legenda:
(D) : directory
(F) : file
Disposizione ad albero

- (D) / : root
	- (D) Images : contiene tutte le immagini del progetto
		- (D) Test: contiene tutte le immagini di dataset usate per il test (sono presenti 22 immagini)
		- (D) Training: contiene tutte le immagini di dataset usate per il training (sono presenti 38 immagini)
		- (D) Squares: contiene i file (formato *.jpg*) delle chessboard extratte dalle immagini di dataset_training tramite *extract_board_script.m*
			-(D) labels_per_image : directory contenente i file .mat delle label di ciascuna immagine di DatasetChessboardExtracted_training
	- (D) Documents: file di testo prodotti per analizzare le immagini da elaborare
		- (F) Analisi iniziale immagini: analisi superficiale delle 48 immagini di dataset assegnate e dei problemi che presentano
		- (F) Problematiche: problemi e difficoltà dell'algoritmo di estrazione delle chessboard (*extract_chessboard_script.m*)
		- (F) Progetto-EI.pptx : powerpoint presentazione del progetto
	- (D) Groundtruth: 
		- (D) GroundTruth_per_image: contiene tutte le stringhe FEN delle immagini presenti nella cartella "Dataset"
		- (F) groundTruth.mat : file matlab contentente la cell groundTruth con tutte le groundTruth della directory GroundTruth_per_image 
		- (F) SchemaSlide.txt : schema seguito per produrre le slide del Dataset di test
		- (F) git-graph.txt : grafo dei branch git al 24 febbraio
	- (D) Scripts: file matlab (*.m*) impiegati per risolvere il problema dato. I scripts appartengono ai rispettivi autori
		- (D) BoardExtraction
			- (F) extractBoard.m
			- (F) extractSquare.m
			- (F) correctPerspective.m
		- (D) Classification
			- (F) FeedClassifier.m
			- (F) GenerateClassifier.m
		- (D) Description
			- (F) computeGHOGDescriptor
			- (F) computeHOGDescriptor
			- (F) computeHuMomentsDescriptor
			- (F) computeImageAsArrayDescriptor
			- (F) computeLBPDescriptor
			- (F) computeZHOGDescriptor
			- (F) generateDescriptor
		- (D) Fen creation
			- (F) computeFEN_classify
			- (F) computeFEN_matching
		- (D) Miscellaneous
			- (F) savuola.m
			- (F) confmat
			- (F) confusionMatrix
			- (F) countErrors
			- (F) expandString
			- (F) generateChess
			- (F) generateLabels
			- (F) generatePath
			- (F) padimage.m
		- (D) Template matching
			- (F) matcher
			- (F) ncc.m
			- (F) zncc.m
			- (F) nssd.m
			- (F) znssd.m
	- (F) Main.m : Main del programma di riconoscimento; è necessario indicare l'immagine di Test su cui eseguire il Main
	- (D) Variables
		- (D) Classifiers : contiene dei classificatori già trainati
		- (D) Features : contiene features già estratte dal training
		- (D) Miscellaneous : altre variabili
	- (D) Papers: file *.pdf* di papers e risorse che abbiamo consultato per lo sviluppo di questo progetto 
	
/// Autori
Gianluca Scarpellini, Federico Belotti

Copyright (c) 2018, Federico Belotti, Gianluca Scarpelllini
All rights reserved.
