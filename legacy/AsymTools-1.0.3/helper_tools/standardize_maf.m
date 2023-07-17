function M = standardize_maf(M),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


rf = {
	{'gene','Hugo_Symbol','Gene_name'},
        {'patient','pat','Tumor_Sample_Barcode','Patient_name'},
	{'chr','Chromosome'},
	{'pos','Position','start','Start_position'},
	{'ref_allele','Reference_Allele','ref'},
	{'newbase','Tumor_Allele','Tum_allele','Alt_allele','Alternate_allele','Tumor_Seq_Allele2','tum_allele2'},
	{'type','Variant_Classification'},
	{'classification','Variant_Type'},
};
f = fieldnames(M);
for i=1:length(rf)
  matches = find(ismember(lower(f),lower(rf{i})));
  if isempty(matches)
  	continue;
  end
  if length(matches)>1
      fprintf('\nMutation file contains multiple columns for %s info:\n', rf{i}{1});
  pr(f(matches));
  match_to_first = find(strcmpi(lower(f),lower(rf{i}{1})));
  if ~isempty(match_to_first), matches = match_to_first; else matches = matches(1); end
        fprintf('Will use %s\n',f{matches});
  end
    M = rename_field(M,f{matches},rf{i}{1});
end

