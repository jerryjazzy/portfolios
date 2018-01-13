function chords = plot_chords(template_matrix, t_template)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot the chord estimaton matrix.
% 
% template_matrix : The chord estimation matrix
% t_template      : The time vector for the chord estimation matrix
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Scale for the number of the x-axis labels to be displayed
[~, chords] = max(template_matrix);
scale = ceil(length(t_template)/18);
xlabels = zeros(1, ceil(length(t_template)/scale));
for i = 1:length(xlabels)
    xlabels(i) = str2num(sprintf('%.2f', t_template(i*scale-(scale-1))));
end
plot(chords, 'ko');
ylabelnames = {'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B',...
               'c', 'c#', 'd', 'd#', 'e', 'f', 'f#', 'g', 'g#', 'a', 'a#', 'b'};
set(gca,'YTick'      , 1:length(template_matrix(:,1)));
set(gca,'YTickLabel' , ylabelnames);
set(gca,'XTick'      , 1:scale:length(template_matrix(1,:)));
set(gca,'XTickLabel' , xlabels);

end