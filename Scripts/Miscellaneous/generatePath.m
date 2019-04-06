%% Script impiegato per generate il path di images
% Non è funzionale alla generazione del classificatore
images = [];
for i = 1 : 78
	if (i <= 9)
		path = '00';
	else
		path = '0';
	end	
	if (exist(['Images', filesep, 'Training', filesep, path, num2str(i), '.jpg'], 'file'))
		for j = 1 : 8
			for k = 1 : 8
					s = ['Images', filesep, 'Squares', filesep, path];
					s = [s, num2str(i), '_', num2str(j), 'x', num2str(k), '.jpg'];
					images = [images; s];          
			end
		end
	end
end

