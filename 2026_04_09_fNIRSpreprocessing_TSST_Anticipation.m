%% Skript zur Auswertung von TSST Anticipation 
% data: TSST session of CPT-TSST study (study 1) and first TSST of ERT study (study 2)
% last edited 2026_04_09 by Isabell Int-Veen 

% add paths with subfolders:
% Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Matlab Code und Workspaces\EigeneFunktionen
% Q:\NAS\Ehlis_Auswertung\Laufwerk_S\routines\2017-04-27

clear all
clc

pfade = { ...
    'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Matlab Code und Workspaces\EigeneFunktionen', ...
    'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\routines\2017-04-27',...
    '\\nacl2svm1.ukt.ad.local\psint1i1\UserProfile\Documents\MATLAB'};

for i = 1:numel(pfade)
    if isfolder(pfade{i})
        addpath(genpath(pfade{i}));
        fprintf('Pfad hinzugefuegt: %s\n', pfade{i});
    else
        warning('Pfad nicht gefunden: %s', pfade{i});
    end
end

clear i pfade

initroutines('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\routines\2017-04-27')
 
%% read data 
S = NirsSubjectData();
S = S.setProperty('read_directory','Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Preprocessing_Matlab\Daten_gesamt');
S = S.setProperty('subject_keyword','VP');
S = S.setProperty('read_type','etg4000');

% CTRL1
S = S.setProperty('read_type','etg4000');
S = S.setProperty('file_name_filter',{'VP','_ctrl1_Probe1_Oxy','.csv'});
S = S.readSubjectData('CTL1.Oxy1');
S = S.setProperty('file_name_filter',{'VP','_ctrl1_Probe1_Deoxy','.csv'});
S = S.readSubjectData('CTL1.Deoxy1');
S = S.setProperty('read_type','etg4000_trigger');
S = S.readSubjectData('CTL1.trigger');

S = S.setProperty('read_type','etg4000');
S = S.setProperty('file_name_filter',{'VP','_ctrl1_Probe2_Oxy','.csv'});
S = S.readSubjectData('CTL1.Oxy2');
S = S.setProperty('file_name_filter',{'VP','_ctrl1_Probe2_Deoxy','.csv'});
S = S.readSubjectData('CTL1.Deoxy2');


% CTRL2
S = S.setProperty('read_type','etg4000');
S = S.setProperty('file_name_filter',{'VP','_ctrl2_Probe1_Oxy','.csv'});
S = S.readSubjectData('CTL2.Oxy1');
S = S.setProperty('file_name_filter',{'VP','_ctrl2_Probe1_Deoxy','.csv'});
S = S.readSubjectData('CTL2.Deoxy1');
S = S.setProperty('read_type','etg4000_trigger');
S = S.readSubjectData('CTL2.trigger');

S = S.setProperty('read_type','etg4000');
S = S.setProperty('file_name_filter',{'VP','_ctrl2_Probe2_Oxy','.csv'});
S = S.readSubjectData('CTL2.Oxy2');
S = S.setProperty('file_name_filter',{'VP','_ctrl2_Probe2_Deoxy','.csv'});
S = S.readSubjectData('CTL2.Deoxy2');

% Arith
S = S.setProperty('read_type','etg4000');
S = S.setProperty('file_name_filter',{'VP','_arit_Probe1_Oxy','.csv'});
S = S.readSubjectData('Arith.Oxy1');
S = S.setProperty('file_name_filter',{'VP','_arit_Probe1_Deoxy','.csv'});
S = S.readSubjectData('Arith.Deoxy1');
S = S.setProperty('read_type','etg4000_trigger');
S = S.readSubjectData('Stress.trigger');

S = S.setProperty('read_type','etg4000');
S = S.setProperty('file_name_filter',{'VP','_arit_Probe2_Oxy','.csv'});
S = S.readSubjectData('Arith.Oxy2');
S = S.setProperty('file_name_filter',{'VP','_arit_Probe2_Deoxy','.csv'});
S = S.readSubjectData('Arith.Deoxy2');


% probeset configuration 

% CTRL1
F = NirsDataFunctor();
F = F.setProperty('function_handle',@separateProbeset34Stress);
F = F.setProperty('input_names', {'CTL1.Oxy1','CTL1.Deoxy1'});
F = F.setProperty('output_names',{'CTL1.Oxy3','CTL1.Deoxy3';...
                                  'CTL1.Oxy4','CTL1.Deoxy4'});
S = S.processData(F);

F = NirsDataFunctor();
F = F.setProperty('function_handle',@separateProbeset56Stress);
F = F.setProperty('input_names', {'CTL1.Oxy2','CTL1.Deoxy2'});
F = F.setProperty('output_names',{'CTL1.Oxy5','CTL1.Deoxy5';...
                                  'CTL1.Oxy6','CTL1.Deoxy6'});
S = S.processData(F);


% CTRL2
F = NirsDataFunctor();
F = F.setProperty('function_handle',@separateProbeset34Stress);
F = F.setProperty('input_names', {'CTL2.Oxy1','CTL2.Deoxy1'});
F = F.setProperty('output_names',{'CTL2.Oxy3','CTL2.Deoxy3';...
                                  'CTL2.Oxy4','CTL2.Deoxy4'});
S = S.processData(F);

F = NirsDataFunctor();
F = F.setProperty('function_handle',@separateProbeset56Stress);
F = F.setProperty('input_names', {'CTL2.Oxy2','CTL2.Deoxy2'});
F = F.setProperty('output_names',{'CTL2.Oxy5','CTL2.Deoxy5';...
                                  'CTL2.Oxy6','CTL2.Deoxy6'});
S = S.processData(F);


% Arith
F = NirsDataFunctor();
F = F.setProperty('function_handle',@separateProbeset34Stress);
F = F.setProperty('input_names', {'Arith.Oxy1','Arith.Deoxy1'});
F = F.setProperty('output_names',{'Arith.Oxy3','Arith.Deoxy3';...
                                  'Arith.Oxy4','Arith.Deoxy4'});
S = S.processData(F);

F = NirsDataFunctor();
F = F.setProperty('function_handle',@separateProbeset56Stress);
F = F.setProperty('input_names', {'Arith.Oxy2','Arith.Deoxy2'});
F = F.setProperty('output_names',{'Arith.Oxy5','Arith.Deoxy5';...
                                  'Arith.Oxy6','Arith.Deoxy6'});
S = S.processData(F);



% merge probesets 

S = S.processData(NirsDataFunctor('function_handle',@ merge, 'input_names',{'CTL1.Oxy3';'CTL1.Oxy4';'CTL1.Oxy5';'CTL1.Oxy6'},'output_names',{'CTL1.Oxy'}));
S = S.processData(NirsDataFunctor('function_handle',@ merge, 'input_names',{'CTL1.Deoxy3';'CTL1.Deoxy4';'CTL1.Deoxy5';'CTL1.Deoxy6'},'output_names',{'CTL1.Deoxy'}));

S = S.processData(NirsDataFunctor('function_handle',@ merge, 'input_names',{'CTL2.Oxy3';'CTL2.Oxy4';'CTL2.Oxy5';'CTL2.Oxy6'},'output_names',{'CTL2.Oxy'}));
S = S.processData(NirsDataFunctor('function_handle',@ merge, 'input_names',{'CTL2.Deoxy3';'CTL2.Deoxy4';'CTL2.Deoxy5';'CTL2.Deoxy6'},'output_names',{'CTL2.Deoxy'}));

S = S.processData(NirsDataFunctor('function_handle',@ merge, 'input_names',{'Arith.Oxy3';'Arith.Oxy4';'Arith.Oxy5';'Arith.Oxy6'},'output_names',{'Arith.Oxy'}));
S = S.processData(NirsDataFunctor('function_handle',@ merge, 'input_names',{'Arith.Deoxy3';'Arith.Deoxy4';'Arith.Deoxy5';'Arith.Deoxy6'},'output_names',{'Arith.Deoxy'}));

% settings 

clear settings P PS;
P = NirsPlotTool();
settings.experiment.time_series{1} = {'name','CTL1.cui','sample_rate',10,'trigger_name','CTL1.trigger'};
settings.experiment.time_series{2} = {'name','CTL2.cui','sample_rate',10,'trigger_name','CTL2.trigger'};
settings.experiment.time_series{3} = {'name','Arith.cui','sample_rate',10,'trigger_name','Stress.trigger'};

settings.experiment.time_series{4} = {'name','CTL1.Oxy','sample_rate',10,'trigger_name','CTL1.trigger'};
settings.experiment.time_series{5} = {'name','CTL1.Deoxy','sample_rate',10,'trigger_name','CTL1.trigger'};
settings.experiment.time_series{6} = {'name','CTL2.Oxy','sample_rate',10,'trigger_name','CTL2.trigger'};
settings.experiment.time_series{7} = {'name','CTL2.Deoxy','sample_rate',10,'trigger_name','CTL2.trigger'};
settings.experiment.time_series{8} = {'name','Arith.Oxy','sample_rate',10,'trigger_name','Stress.trigger'};
settings.experiment.time_series{9} = {'name','Arith.Deoxy','sample_rate',10,'trigger_name','Stress.trigger'};

settings.experiment.category{1} = {'name','TriggerA','trigger_token',1}; % for analysis of window 3
% settings.experiment.category{1} = {'name','TriggerA','trigger_token',9}; % for analysis of window 1 and 2

P = P.setProperties(settings);   
P = NirsPlotTool();
P = P.setProperty('show_probeset','on');
P = P.setProperties(settings);

PS = NirsProbeset('brain_coord_file','Q:\NAS\Ehlis_Auswertung\Laufwerk_S\\AG-Mitglieder\David\Studie Stress Rumination\Koords\NIRS-probesetXYZ_Alle2.txt');
settings.plot_tool.probesets{1} = {'name','Gesamt','probeset',PS};

P = P.setProperties(settings);
P = P.setProperty('probesets',{'name','Gesamt','probeset',PS});

P = P.setProperties(settings);   

P = P.setProperty('show_probeset','on');

P = P.setProperties(settings);

Subject=S.tags(1);


Bedingungen={'CTL1.Oxy';'CTL2.Oxy';'Arith.Oxy'};
Bedingungen2={'CTL1cui';'CTL2cui';'Arithcui'};

%% find NaNs

clear NaNOut
for x=1:size(Bedingungen,1)
    clear dCui DataRS DataVar Out
        Subject=S.tags(1);
            for k=1:length(Subject)
                dCui = S.getSubjectData(Subject{k},Bedingungen{x});
                DataRS{k,1}(:,:)=dCui(:,:);
            end
    clear dCui
        for k=1:length(Subject)
            for i=1:size(DataRS{k,1}(:,:),2)
                DataVar(k,i) = var(DataRS{k,1}(:,i));
            end
        end
    
        for k=1:size(DataVar,1)
            for i=1:size(DataVar,2)
                if isnan(DataVar(k,i))==1
                    Out(k,i)=1;
                else
                    Out(k,i)=0;
              	end
            end
        end

    NaNOut.(Bedingungen2{x}).percent=mean(Out,2)*100;
    
    for k=1:size(Out,1)
      a=Out(k,:)'
      NaNOut.(Bedingungen2{x}).Channel{k,1}(:)=find(a);
      sid=Subject{k};
      NaNOut.(Bedingungen2{x}).Channel{k,2}(:)=sid;
       clear a sid
    end
end
   
%% interpolate NaN 

% template:
% F = NirsDataFunctor(); % clears output 
% F = F.setProperty('parameters',{*Channel*,{[* * * *]}});S = S.processData(F,*ID*);

% ctrl1 
F = NirsDataFunctor(); % clears output 
F = F.setProperty('function_handle',@NAfilt.interpolateChannel);
F = F.setProperty('input_names',{'CTL1.Oxy','CTL1.Deoxy'}); 

F = F.setProperty('parameters',{8,{[3 6 9]}});S = S.processData(F,1006);
F = F.setProperty('parameters',{11,{[6 9 12]}});S = S.processData(F,1006);

F = F.setProperty('parameters',{30,{[25 26 35]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{31,{[26 27 35]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{32,{[27 28 37]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{34,{[29 38 39]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{36,{[35 37 40 41]}});S = S.processData(F,1008);

F = F.setProperty('parameters',{25,{[26 29]}});S = S.processData(F,1015);
F = F.setProperty('parameters',{30,{[26 34 35]}});S = S.processData(F,1015);

F = F.setProperty('parameters',{29,{[25 34 38]}});S = S.processData(F,1016);
F = F.setProperty('parameters',{37,{[32 33 41 42]}});S = S.processData(F,1016);

F = F.setProperty('parameters',{45,{[40 41 44 46]}});S = S.processData(F,1018);

F = F.setProperty('parameters',{1,{[2 3 4]}});S = S.processData(F,1020);

F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1025);

F = F.setProperty('parameters',{10,{[5 7 9]}});S = S.processData(F,1029);
F = F.setProperty('parameters',{12,{[7 9 11]}});S = S.processData(F,1029);

F = F.setProperty('parameters',{44,{[39 40 43 45]}});S = S.processData(F,1034);

F = F.setProperty('parameters',{29,{[25 34 38]}});S = S.processData(F,1046);

F = F.setProperty('parameters',{26,{[25 27 35]}});S = S.processData(F,1051);
F = F.setProperty('parameters',{30,{[25 34 35]}});S = S.processData(F,1051);
F = F.setProperty('parameters',{31,{[27 35 36]}});S = S.processData(F,1051);
F = F.setProperty('parameters',{32,{[27 28 36]}});S = S.processData(F,1051);
F = F.setProperty('parameters',{37,{[33 41 42]}});S = S.processData(F,1051);

F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1054);

F = F.setProperty('parameters',{30,{[25 26 29 31 35 34]}});S = S.processData(F,1102);

F = F.setProperty('parameters',{2,{[4 1]}});S = S.processData(F,1104);
F = F.setProperty('parameters',{5,{[4 10]}});S = S.processData(F,1104);
F = F.setProperty('parameters',{7,{[4 6 9 10]}});S = S.processData(F,1104);

F = F.setProperty('parameters',{22,{[17 19 24 21]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{32,{[27 28 31 33 36]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{37,{[33 36 42 41]}});S = S.processData(F,1109);

F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1111);

F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1112);

F = F.setProperty('parameters',{4,{[2 5 7 1 6 3]}});S = S.processData(F,1117);

F = F.setProperty('parameters',{4,{[2 5 7 1 6 3]}});S = S.processData(F,1118);

F = F.setProperty('parameters',{40,{[35 36 39 41 44 45]}});S = S.processData(F,1120);

F = F.setProperty('parameters',{11,{[6 8 9]}});S = S.processData(F,1121);
F = F.setProperty('parameters',{12,{[10 7 9]}});S = S.processData(F,1121);

F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{41,{[36 37 40 42 45 46]}});S = S.processData(F,1122);

F = F.setProperty('parameters',{15,{[13 16]}});S = S.processData(F,1123);
F = F.setProperty('parameters',{18,{[13 16 21]}});S = S.processData(F,1123);
F = F.setProperty('parameters',{20,{[24 21 13]}});S = S.processData(F,1123);
F = F.setProperty('parameters',{23,{[21 24]}});S = S.processData(F,1123);

F = F.setProperty('parameters',{28,{[27 33 37]}});S = S.processData(F,1124);
F = F.setProperty('parameters',{32,{[27 31 33 36 37]}});S = S.processData(F,1124);

F = F.setProperty('parameters',{15,{[13 16]}});S = S.processData(F,1130);
F = F.setProperty('parameters',{18,{[13 16 21]}});S = S.processData(F,1130);
F = F.setProperty('parameters',{20,{[24 21 13]}});S = S.processData(F,1130);
F = F.setProperty('parameters',{23,{[21 24]}});S = S.processData(F,1130);

F = F.setProperty('parameters',{36,{[27 31 32 40 41 45]}});S = S.processData(F,1135);

F = F.setProperty('parameters',{18,{[20 15 23 13 21 16]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{22,{[24 21 19]}});S = S.processData(F,1143);


F = F.setProperty('parameters',{8,{[3 6 9]}});S = S.processData(F,2017);
F = F.setProperty('parameters',{11,{[9 12]}});S = S.processData(F,2017);
F = F.setProperty('parameters',{30,{[35 34 25 26]}});S = S.processData(F,2024);
F = F.setProperty('parameters',{29,{[25 30 34 38]}});S = S.processData(F,2030);
F = F.setProperty('parameters',{32,{[27 28 31 33 36 37]}});S = S.processData(F,2021);
F = F.setProperty('parameters',{31,{[26 27 30 32]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{36,{[32 37 41 40]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{45,{[40 41 46]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{29,{[38 34 25]}});S = S.processData(F,2032);
F = F.setProperty('parameters',{21,{[18 16 19]}});S = S.processData(F,2033);
F = F.setProperty('parameters',{23,{[20 18]}});S = S.processData(F,2033);
F = F.setProperty('parameters',{24,{[22 19]}});S = S.processData(F,2033);
F = F.setProperty('parameters',{29,{[38 34 ]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{31,{[30 26 27 32]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{35,{[30 34 39]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{36,{[27 32 41 45]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{40,{[39 44 45 41]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{42,{[46 41 37 33]}});S = S.processData(F,2034);

% ctrl2 
F = NirsDataFunctor(); % clears output 
F = F.setProperty('function_handle',@NAfilt.interpolateChannel);
F = F.setProperty('input_names',{'CTL2.Oxy','CTL2.Deoxy'});

F = F.setProperty('parameters',{8,{[3 6 9]}});S = S.processData(F,1006);
F = F.setProperty('parameters',{11,{[6 9 12]}});S = S.processData(F,1006);

F = F.setProperty('parameters',{30,{[25 26 35]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{34,{[29 38 39]}});S = S.processData(F,1008);

F = F.setProperty('parameters',{25,{[26 29]}});S = S.processData(F,1015);
F = F.setProperty('parameters',{30,{[26 34 35]}});S = S.processData(F,1015);
F = F.setProperty('parameters',{33,{[28 37 42]}});S = S.processData(F,1015);
F = F.setProperty('parameters',{45,{[40 41 44 46]}});S = S.processData(F,1015);

F = F.setProperty('parameters',{29,{[25 34 38]}});S = S.processData(F,1016);
F = F.setProperty('parameters',{37,{[32 33 41 42]}});S = S.processData(F,1016);

F = F.setProperty('parameters',{45,{[40 41 44 46]}});S = S.processData(F,1018);

F = F.setProperty('parameters',{28,{[27 32 37]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{33,{[32 37 42]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{46,{[41 42 45]}});S = S.processData(F,1024);

F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1025);

F = F.setProperty('parameters',{10,{[5 7 9]}});S = S.processData(F,1029);
F = F.setProperty('parameters',{12,{[7 9 11]}});S = S.processData(F,1029);

F = F.setProperty('parameters',{44,{[39 40 43 45]}});S = S.processData(F,1034);

F = F.setProperty('parameters',{39,{[34 35 44]}});S = S.processData(F,1048);
F = F.setProperty('parameters',{43,{[34 38 44]}});S = S.processData(F,1048);

F = F.setProperty('parameters',{26,{[25 27 35]}});S = S.processData(F,1051);
F = F.setProperty('parameters',{30,{[25 34 35]}});S = S.processData(F,1051);
F = F.setProperty('parameters',{31,{[27 35 36]}});S = S.processData(F,1051);
F = F.setProperty('parameters',{32,{[27 28 36]}});S = S.processData(F,1051);
F = F.setProperty('parameters',{37,{[33 41 42]}});S = S.processData(F,1051);

F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1054);

F = F.setProperty('parameters',{30,{[25 26 29 31 34]}});S = S.processData(F,1102);
F = F.setProperty('parameters',{35,{[26 31 40 44]}});S = S.processData(F,1102);
F = F.setProperty('parameters',{39,{[38 34 35 40 43 44]}});S = S.processData(F,1102);
F = F.setProperty('parameters',{45,{[40 36 41]}});S = S.processData(F,1102);

F = F.setProperty('parameters',{2,{[4 7]}});S = S.processData(F,1104);
F = F.setProperty('parameters',{5,{[4 7]}});S = S.processData(F,1104);

F = F.setProperty('parameters',{3,{[1 2 6 7]}});S = S.processData(F,1108);

F = F.setProperty('parameters',{22,{[24 21 19]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{29,{[25 34]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{30,{[25 26 31 34 35]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{32,{[27 28 31 36]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{33,{[28 42]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{37,{[36 41 42]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{46,{[41 42 45]}});S = S.processData(F,1109);

F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1111);

F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1112);

F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1120);
F = F.setProperty('parameters',{40,{[35 36 39 41 44 45]}});S = S.processData(F,1120);

F = F.setProperty('parameters',{11,{[6 8 9 12]}});S = S.processData(F,1121);

F = F.setProperty('parameters',{6,{[4 9 1 11 3 8]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{41,{[36 37 40 42 45 46]}});S = S.processData(F,1122);

F = F.setProperty('parameters',{28,{[27 33 37]}});S = S.processData(F,1124);
F = F.setProperty('parameters',{32,{[27 31 33 36 37]}});S = S.processData(F,1124);

F = F.setProperty('parameters',{36,{[27 31 32 40 41 45]}});S = S.processData(F,1135);

F = F.setProperty('parameters',{32,{[27 28 31 33 37]}});S = S.processData(F,1140);
F = F.setProperty('parameters',{36,{[27 31  41 45]}});S = S.processData(F,1140);
F = F.setProperty('parameters',{40,{[35 39 41 44 45]}});S = S.processData(F,1140);

F = F.setProperty('parameters',{15,{[13 16]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{18,{[13 16 21]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{20,{[24 21 13]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{22,{[21 24 19]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{23,{[21 24]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{38,{[34 39 43]}});S = S.processData(F,1143);


F = F.setProperty('parameters',{13,{[15 18]}});S = S.processData(F,2011);
F = F.setProperty('parameters',{14,{[17 19]}});S = S.processData(F,2011);
F = F.setProperty('parameters',{16,{[18 19 ]}});S = S.processData(F,2011);
F = F.setProperty('parameters',{37,{[36 41 32 33 42]}});S = S.processData(F,2013);
F = F.setProperty('parameters',{8,{[3 6 9]}});S = S.processData(F,2017);
F = F.setProperty('parameters',{11,{[9 12]}});S = S.processData(F,2017);
F = F.setProperty('parameters',{32,{[27 28 31 33 36 37]}});S = S.processData(F,2021);
F = F.setProperty('parameters',{30,{[35 34 25 26]}});S = S.processData(F,2024);
F = F.setProperty('parameters',{29,{[25 30 34 38]}});S = S.processData(F,2030);
F = F.setProperty('parameters',{32,{[27 28 31 33 36 37]}});S = S.processData(F,2021);
F = F.setProperty('parameters',{4,{[1 3 2 5]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{6,{[1 3 8 11]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{7,{[2 5 10 12]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{9,{[8 11 12 10]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{31,{[26 27 30 32]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{39,{[38 34 35 40]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{43,{[38 34]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{44,{[35 40]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{45,{[40 41 46]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{29,{[38 34 25]}});S = S.processData(F,2032);
F = F.setProperty('parameters',{21,{[18 16 19]}});S = S.processData(F,2033);
F = F.setProperty('parameters',{23,{[20 18]}});S = S.processData(F,2033);
F = F.setProperty('parameters',{24,{[22 19]}});S = S.processData(F,2033);
F = F.setProperty('parameters',{29,{[38 34 ]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{31,{[30 26 27 32]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{35,{[30 34 39]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{36,{[27 32 41 45]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{40,{[39 44 45 41]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{42,{[46 41 37 33]}});S = S.processData(F,2034);


% arith
F = NirsDataFunctor(); % clears output 
F = F.setProperty('function_handle',@NAfilt.interpolateChannel);
F = F.setProperty('input_names',{'Arith.Oxy','Arith.Deoxy'}); 

F = F.setProperty('parameters',{30,{[25 26 35]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{34,{[29 38 39]}});S = S.processData(F,1008);

F = F.setProperty('parameters',{39,{[34 35 38 40]}});S = S.processData(F,1013);
F = F.setProperty('parameters',{43,{[34 38]}});S = S.processData(F,1013);
F = F.setProperty('parameters',{44,{[35 40 45]}});S = S.processData(F,1013);

F = F.setProperty('parameters',{34,{[29 30 39]}});S = S.processData(F,1014);
F = F.setProperty('parameters',{37,{[32 33 41 42]}});S = S.processData(F,1014);
F = F.setProperty('parameters',{38,{[29 43]}});S = S.processData(F,1014);

F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1015);

F = F.setProperty('parameters',{29,{[25 34 38]}});S = S.processData(F,1016);

F = F.setProperty('parameters',{45,{[40 41 44 46]}});S = S.processData(F,1018);

F = F.setProperty('parameters',{1,{[2 3 4]}});S = S.processData(F,1029);
F = F.setProperty('parameters',{12,{[9 10 11]}});S = S.processData(F,1029);

F = F.setProperty('parameters',{44,{[39 40 43 45]}});S = S.processData(F,1034);

F = F.setProperty('parameters',{26,{[25 27 35]}});S = S.processData(F,1051);
F = F.setProperty('parameters',{30,{[25 34 35]}});S = S.processData(F,1051);
F = F.setProperty('parameters',{31,{[27 35 36]}});S = S.processData(F,1051);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1051);

F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1054);

F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1102);

F = F.setProperty('parameters',{2,{[1 4]}});S = S.processData(F,1104);
F = F.setProperty('parameters',{5,{[4 10]}});S = S.processData(F,1104);
F = F.setProperty('parameters',{7,{[4 9 10 12]}});S = S.processData(F,1104);

F = F.setProperty('parameters',{22,{[19 21 24]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{32,{[27 28 31 33 36]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{37,{[33 36 41 42 46]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{39,{[34 35 38 40 43 44]}});S = S.processData(F,1109);

F = F.setProperty('parameters',{40,{[35 36 39 41 44 45]}});S = S.processData(F,1120);

F = F.setProperty('parameters',{11,{[6 8 9]}});S = S.processData(F,1121);
F = F.setProperty('parameters',{12,{[7 9 10]}});S = S.processData(F,1121);

F = F.setProperty('parameters',{4,{[1 2 3 5 7]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{6,{[1 3 8 9 11]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{32,{[27 28 31 33]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{36,{[31 40 45]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{37,{[33 42 46]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{41,{[40 42 45 46]}});S = S.processData(F,1122);

F = F.setProperty('parameters',{28,{[27 33 37]}});S = S.processData(F,1124);
F = F.setProperty('parameters',{32,{[27 31 33 36 37]}});S = S.processData(F,1124);

F = F.setProperty('parameters',{15,{[13 16]}});S = S.processData(F,1130);
F = F.setProperty('parameters',{18,{[13 16 21 23]}});S = S.processData(F,1130);
F = F.setProperty('parameters',{20,{[21 23]}});S = S.processData(F,1130);

F = F.setProperty('parameters',{26,{[25 30 35]}});S = S.processData(F,1131);
F = F.setProperty('parameters',{27,{[28 36]}});S = S.processData(F,1131);
F = F.setProperty('parameters',{31,{[30 35 36]}});S = S.processData(F,1131);
F = F.setProperty('parameters',{32,{[28 33 36]}});S = S.processData(F,1131);
F = F.setProperty('parameters',{37,{[33 36 42 46]}});S = S.processData(F,1131);
F = F.setProperty('parameters',{41,{[36 40 42 45 46]}});S = S.processData(F,1131);

F = F.setProperty('parameters',{20,{[15 18 21 23]}});S = S.processData(F,1137);

F = F.setProperty('parameters',{32,{[27 28 31 33 36 37]}});S = S.processData(F,1140);

F = F.setProperty('parameters',{29,{[25 30 34 38]}});S = S.processData(F,1143);


F = F.setProperty('parameters',{4,{[2 1]}});S = S.processData(F,2002);
F = F.setProperty('parameters',{6,{[3 8]}});S = S.processData(F,2002);
F = F.setProperty('parameters',{7,{[2 5 10 12]}});S = S.processData(F,2002);
F = F.setProperty('parameters',{9,{[8 11 12 10]}});S = S.processData(F,2002);
F = F.setProperty('parameters',{14,{[17 16 13]}});S = S.processData(F,2011);
F = F.setProperty('parameters',{8,{[3 6 9]}});S = S.processData(F,2017);
F = F.setProperty('parameters',{11,{[9 12]}});S = S.processData(F,2017);
F = F.setProperty('parameters',{25,{[30 26]}});S = S.processData(F,2017);
F = F.setProperty('parameters',{29,{[38 34 30]}});S = S.processData(F,2017);
F = F.setProperty('parameters',{30,{[35 34 25 26]}});S = S.processData(F,2024);
F = F.setProperty('parameters',{20,{[21 18 15 23]}});S = S.processData(F,2026);
F = F.setProperty('parameters',{29,{[25 30 34 38]}});S = S.processData(F,2030);
F = F.setProperty('parameters',{4,{[1 6 2 7]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{5,{[2 7 4 10]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{45,{[44 40 41 46]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{29,{[38 34 25]}});S = S.processData(F,2032);
F = F.setProperty('parameters',{25,{[26 30]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{29,{[38 34 ]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{31,{[30 26 27 32]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{35,{[30 34 39]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{36,{[27 32 41 45]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{40,{[39 44 45 41]}});S = S.processData(F,2034);
F = F.setProperty('parameters',{42,{[46 41 37 33]}});S = S.processData(F,2034);


%% corrections 
%T DDR

S = S.processData(NirsDataFunctor('function_handle',@(X) TDDR(X,10),'input_names',{'CTL1.Oxy','CTL1.Deoxy','CTL2.Oxy','CTL2.Deoxy','Arith.Oxy','Arith.Deoxy'}));

% Bandpass

F = NirsDataFunctor('function_handle',@bandpass,...
                    'parameters',{[0.01 0.1],10,'new'},... 
                    'input_names', {'CTL1.Oxy','CTL1.Deoxy','CTL2.Oxy','CTL2.Deoxy','Arith.Oxy','Arith.Deoxy'});
S = S.processData(F);

% Correlation Based Signal Improvement (CBSI)

F = NirsDataFunctor();
F = F.setProperty('function_handle',@NAfilt.correlationBasedSignalImprovement);
F = F.setProperty('input_names', {'CTL1.Oxy','CTL2.Oxy','Arith.Oxy';...    
                                  'CTL1.Deoxy','CTL2.Deoxy','Arith.Deoxy'}); 
F = F.setProperty('output_names',{'CTL1.cui','CTL2.cui','Arith.cui'}); 
S = S.processData(F);


%% OXY conditions 
Subject=S.tags(1)

Bedingungen={'CTL1.cui';'CTL2.cui';'Arith.cui'}
Bedingungen2={'CTL1cui';'CTL2cui';'Arithcui'}

%% DEOXY conditions 
Subject=S.tags(1)

Bedingungen={'CTL1.Deoxy';'CTL2.Deoxy';'Arith.Deoxy'}
Bedingungen2={'CTL1deoxy';'CTL2deoxy';'Arithdeoxy'}

%% find NaNs (in case they are created by CBSI)

clear NaNOut
for x=1:size(Bedingungen,1)
	clear dCui DataRS DataVar Out 
        Subject=S.tags(1);
            for k=1:length(Subject)
                dCui = S.getSubjectData(Subject{k},Bedingungen{x});
                DataRS{k,1}(:,:)=dCui(:,:);
            end
    clear dCui
        for k=1:length(Subject)
            for i=1:size(DataRS{k,1}(:,:),2)
                DataVar(k,i) = var(DataRS{k,1}(:,i));
            end
        end
        
    for k=1:size(DataVar,1)
        for i=1:size(DataVar,2)
            if isnan(DataVar(k,i))==1
                Out(k,i)=1;
            else 
                Out(k,i)=0;
            end
        end
    end
    
    NaNOut.(Bedingungen2{x}).percent=mean(Out,2)*100;

    for k=1:size(Out,1)
        a=Out(k,:)'
        NaNOut.(Bedingungen2{x}).Channel{k,1}(:)=find(a);
        sid=Subject{k};
        NaNOut.(Bedingungen2{x}).Channel{k,2}(:)=sid;
        clear a sid
	end
end

%% NaN Interpolieren (nochmal)
% hier weichen die VPN ab von ERT Skript 

% Vorlage:
% F = NirsDataFunctor(); % macht den output wieder leer
% F = F.setProperty('parameters',{*Channel*,{[* * * *]}});S = S.processData(F,*ID*);

% control task 1
F = NirsDataFunctor(); % macht den output wieder leer
F = F.setProperty('function_handle',@NAfilt.interpolateChannel);
F = F.setProperty('input_names',{'CTL1.cui','CTL1.Deoxy'}); 

F = F.setProperty('parameters',{11,{[8 9 12]}});S = S.processData(F,1050);

F = F.setProperty('parameters',{1,{[3 4 6]}});S = S.processData(F,1118);

F = F.setProperty('parameters',{20,{[18 15 ]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{23,{[24 21]}});S = S.processData(F,2029);


% control task 2
F = NirsDataFunctor(); % macht den output wieder leer
F = F.setProperty('function_handle',@NAfilt.interpolateChannel);
F = F.setProperty('input_names',{'CTL2.cui', 'CTL2.Deoxy'}); 

F = F.setProperty('parameters',{28,{[27 32 37]}});S = S.processData(F,1009);
F = F.setProperty('parameters',{33,{[32 37 42]}});S = S.processData(F,1009);


F = F.setProperty('parameters',{11,{[8 9 12]}});S = S.processData(F,1050);

F = F.setProperty('parameters',{3,{[1 4 6]}});S = S.processData(F,1108);

F = F.setProperty('parameters',{32,{[27 28 31 33 36 37]}});S = S.processData(F,1109);

F = F.setProperty('parameters',{1,{[2 3 6]}});S = S.processData(F,1118);
F = F.setProperty('parameters',{4,{[2 3 6 7]}});S = S.processData(F,1118);

F = F.setProperty('parameters',{16,{[13 14 15 17 18 19]}});S = S.processData(F,1120);

F = F.setProperty('parameters',{23,{[18 20 21]}});S = S.processData(F,1123);

F = F.setProperty('parameters',{14,{[13 16 19]}});S = S.processData(F,1130);
F = F.setProperty('parameters',{17,{[16 19 22]}});S = S.processData(F,1130);

F = F.setProperty('parameters',{21,{[18 19]}});S = S.processData(F,2029);
F = F.setProperty('parameters',{23,{[24 20]}});S = S.processData(F,2029);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,2053);


% arith
F = NirsDataFunctor(); % macht den output wieder leer
F = F.setProperty('function_handle',@NAfilt.interpolateChannel);
F = F.setProperty('input_names',{'Arith.cui', 'Arith.Deoxy'}); 

F = F.setProperty('parameters',{11,{[8 9 12]}});S = S.processData(F,1050);

F = F.setProperty('parameters',{1,{[2 4 6]}});S = S.processData(F,1108);
F = F.setProperty('parameters',{3,{[4 6 8]}});S = S.processData(F,1108);

F = F.setProperty('parameters',{14,{[16 17 19]}});S = S.processData(F,1112);

F = F.setProperty('parameters',{1,{[2 3 6]}});S = S.processData(F,1118);
F = F.setProperty('parameters',{4,{[2 3 6 7]}});S = S.processData(F,1118);
F = F.setProperty('parameters',{30,{[25 26 29 31 34]}});S = S.processData(F,1118);
F = F.setProperty('parameters',{35,{[31 39 40]}});S = S.processData(F,1118);

F = F.setProperty('parameters',{16,{[13 14 18 19]}});S = S.processData(F,1120);

F = F.setProperty('parameters',{13,{[14 15]}});S = S.processData(F,1123);

F = F.setProperty('parameters',{15,{[13 16 18]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{20,{[18 21 23]}});S = S.processData(F,1143);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,2001);

%% define ROIs 

lIFG=[7 9 6]
lDLPFC=[10 12 11]
rIFG=[18 21 19]
rDLPFC=[20 23 24]
SAC=[27 26 25 28 30 31 32 35 36]
close all

%% Plot ROI channels for visual inspection for each subjects: control task 1
close all

s = Subject{2};
P = P.plotChannels(S,s,[rIFG,lIFG,rDLPFC,lDLPFC,SAC],{'CTL1.Deoxy'},{'b'},{'-'});
P = P.showTrigger(S,s,'CTL1.Deoxy',4);

%% Plot ROI channels for visual inspection for each subjects: control task 2
close all

s = Subject{97};
P = P.plotChannels(S,s,[rIFG,lIFG,rDLPFC,lDLPFC,SAC],{'CTL2.cui'},{'b'},{'-'});
P = P.showTrigger(S,s,'CTL2.cui',4);

%% Plot ROI channels for visual inspection for each subjects: artihmetic task of the TSST
close all

s = Subject{97};
P = P.plotChannels(S,s,[rIFG,lIFG,rDLPFC,lDLPFC,SAC],{'Arith.cui'},{'b'},{'-'});
P = P.showTrigger(S,s,'Arith.cui',4);

%% show Brodman areas
% showBrodmann([5 7 9 19 44 45 46 47],'show_legend',true,'color_map',lines,'channel_style','ids', 'probeset',[PS]);


%% create new triggers 9 for window 2 and window 1 export
cd('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Matlab Code und Workspaces\EigeneFunktionen')

fs = 10;             % sampling frequency in Hz
marker = 1;          % trigger before new trigger should be created
newTrigger = 9;      % new trigger 


for i = 1:size(Subject, 1)

    trigger_CTL1 = S.getSubjectData(Subject{i}, 'CTL1.trigger');
    trigger_CTL2 = S.getSubjectData(Subject{i}, 'CTL2.trigger');
    trigger_Stress = S.getSubjectData(Subject{i}, 'Stress.trigger');
    
    trigger_CTL1 = NewTrigger_Isa(trigger_CTL1, marker, newTrigger, fs);
    trigger_CTL2 = NewTrigger_Isa(trigger_CTL2, marker, newTrigger, fs);
    trigger_Stress = NewTrigger_Isa(trigger_Stress, marker, newTrigger, fs);

    S = S.addSubjectData(Subject{i}, 'CTL1.trigger', trigger_CTL1);
    S = S.addSubjectData(Subject{i}, 'CTL2.trigger', trigger_CTL2);
    S = S.addSubjectData(Subject{i}, 'Stress.trigger', trigger_Stress);

    fprintf('Subject %d: New trigger created for CTL1: %d, CTL2: %d, Stress: %d\n', ...
        Subject{i}, sum(trigger_CTL1==newTrigger), sum(trigger_CTL2==newTrigger), sum(trigger_Stress==newTrigger));
    
end


%% check how many triggers there are for each subject and condition 

tasks = {'CTL1','CTL2','Stress'};

for t = 1:numel(tasks)
    taskName = tasks{t};
    trigger_new = S.getSubjectData(Subject{1}, [taskName '.trigger']);
    uniqueTriggers = unique(trigger_new(trigger_new~=0));
    fprintf('%s neue Triggerwerte: ', taskName);
    fprintf('%d ', uniqueTriggers);
    fprintf('\n');
end


%% check whether new trigger 9 is actrually 15 s before trigger 1 
fs = 10; % sampling frequency in Hz 

for i = 1:size(Subject,1)
   
    tasks = {'CTL1','CTL2','Stress'};
    
    for t = 1:numel(tasks)
        test = S.getSubjectData(Subject{i}, [tasks{t} '.trigger']);
        trigger_idx = find(test);
        TriggerDaten.trigger{t,i} = test(trigger_idx);
        TriggerDaten.AnzahlTrigger{t,i} = numel(trigger_idx); % number of triggers
        TriggerDaten.Zeitpunkt{t,i} = trigger_idx / fs; % time point in seconds
        
    end
end


%% delete all trigger "4" = endtrigger of the trials 

cd('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Matlab Code und Workspaces\EigeneFunktionen')

deleteTrigger = 4;   % trigger to be deleted 

for i = 1:size(Subject, 1)

    trigger_CTL1   = S.getSubjectData(Subject{i}, 'CTL1.trigger');
    trigger_CTL2   = S.getSubjectData(Subject{i}, 'CTL2.trigger');
    trigger_Stress = S.getSubjectData(Subject{i}, 'Stress.trigger');
    
    trigger_CTL1(trigger_CTL1 == deleteTrigger) = 0;
    trigger_CTL2(trigger_CTL2 == deleteTrigger) = 0;
    trigger_Stress(trigger_Stress == deleteTrigger) = 0;

    S = S.addSubjectData(Subject{i}, 'CTL1.trigger', trigger_CTL1);
    S = S.addSubjectData(Subject{i}, 'CTL2.trigger', trigger_CTL2);
    S = S.addSubjectData(Subject{i}, 'Stress.trigger', trigger_Stress);

    fprintf('Subject %d: Number of trigger 4 → CTL1: %d, CTL2: %d, Stress: %d\n', ...
        Subject{i}, ...
        sum(trigger_CTL1 == deleteTrigger), ...
        sum(trigger_CTL2 == deleteTrigger), ...
        sum(trigger_Stress == deleteTrigger));
end

%% delete all trigger "1" = trigger indicating the beginning of each trial 

cd('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Matlab Code und Workspaces\EigeneFunktionen')

deleteTrigger = 1;   % trigger to be deleted 

for i = 1:size(Subject, 1)
    
    trigger_CTL1   = S.getSubjectData(Subject{i}, 'CTL1.trigger');
    trigger_CTL2   = S.getSubjectData(Subject{i}, 'CTL2.trigger');
    trigger_Stress = S.getSubjectData(Subject{i}, 'Stress.trigger');
    
    trigger_CTL1(trigger_CTL1 == deleteTrigger) = 0;
    trigger_CTL2(trigger_CTL2 == deleteTrigger) = 0;
    trigger_Stress(trigger_Stress == deleteTrigger) = 0;
    
    S = S.addSubjectData(Subject{i}, 'CTL1.trigger', trigger_CTL1);
    S = S.addSubjectData(Subject{i}, 'CTL2.trigger', trigger_CTL2);
    S = S.addSubjectData(Subject{i}, 'Stress.trigger', trigger_Stress);
    
    fprintf('Subject %d: Number of trigger 1 → CTL1: %d, CTL2: %d, Stress: %d\n', ...
        Subject{i}, ...
        sum(trigger_CTL1 == deleteTrigger), ...
        sum(trigger_CTL2 == deleteTrigger), ...
        sum(trigger_Stress == deleteTrigger));
end


%% interpolation of single channels identified by visual inspection 

% ctrl1 
F = NirsDataFunctor(); % clear output 
F = F.setProperty('function_handle',@NAfilt.interpolateChannel);
F = F.setProperty('input_names',{'CTL1.cui', 'CTL1.Deoxy'}); 

F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1002);
F = F.setProperty('parameters',{21,{[18 19 23 24]}});S = S.processData(F,1002);

F = F.setProperty('parameters',{6,{[3 4 9]}});S = S.processData(F,1003);
F = F.setProperty('parameters',{8,{[3 11]}});S = S.processData(F,1003);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1005);

F = F.setProperty('parameters',{10,{[5 7 12]}});S = S.processData(F,1006);
F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1006);

F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1007);

F = F.setProperty('parameters',{26,{[25 30 31]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{27,{[28 31 32]}});S = S.processData(F,1008);

F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1011);

F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1013);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1014);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1014);

F = F.setProperty('parameters',{26,{[25 27 30 31]}});S = S.processData(F,1015);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1016);
F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1016);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1016);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1017);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1017);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1017);

F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1018);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1019);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1019);

F = F.setProperty('parameters',{9,{[6 7 11]}});S = S.processData(F,1020);
F = F.setProperty('parameters',{12,{[10 11]}});S = S.processData(F,1020);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1020);

F = F.setProperty('parameters',{28,{[27 32 33]}});S = S.processData(F,1021);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1021);

F = F.setProperty('parameters',{11,{[8 9 12]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{24,{[21 22 23]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{28,{[27 33 37]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{32,{[27 36 37]}});S = S.processData(F,1024);

F = F.setProperty('parameters',{21,{[18 19 23 24]}});S = S.processData(F,1025);
F = F.setProperty('parameters',{27,{[26 28 31]}});S = S.processData(F,1025);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1025);
F = F.setProperty('parameters',{32,{[28 36 37]}});S = S.processData(F,1025);

F = F.setProperty('parameters',{32,{[27 28 36 32]}});S = S.processData(F,1026);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1029);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1029);
F = F.setProperty('parameters',{32,{[27 28 37]}});S = S.processData(F,1029);
F = F.setProperty('parameters',{36,{[35 37 40 41]}});S = S.processData(F,1029);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1030);
F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1030);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1030);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1030);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1032);

F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1033);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1034);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1034);

F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1035);

F = F.setProperty('parameters',{11,{[8 9 12]}});S = S.processData(F,1037);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1038);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1039);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1039);

F = F.setProperty('parameters',{18,{[15 16 21]}});S = S.processData(F,1041);

F = F.setProperty('parameters',{18,{[15 16 21]}});S = S.processData(F,1042);
F = F.setProperty('parameters',{20,{[15 21 23]}});S = S.processData(F,1042);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1042);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1043);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1043);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1043);

F = F.setProperty('parameters',{6,{[3 4 8]}});S = S.processData(F,1044);
F = F.setProperty('parameters',{7,{[4 5 10]}});S = S.processData(F,1044);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1044);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1046);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1046);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1048);
F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1048);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1048);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1048);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1048);

F = F.setProperty('parameters',{28,{[27 32 33]}});S = S.processData(F,1050);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1052);
F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1052);

F = F.setProperty('parameters',{36,{[31 32 40 41]}});S = S.processData(F,1053);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1055);
F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1055);
F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1055);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1056);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1056);

F = F.setProperty('parameters',{20,{[15 18 21 23]}});S = S.processData(F,1102);
F = F.setProperty('parameters',{35,{[30 31 39 40]}});S = S.processData(F,1102);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1103);
F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1103);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1103);

F = F.setProperty('parameters',{18,{[15 16 21]}});S = S.processData(F,1107);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1107);
F = F.setProperty('parameters',{20,{[15 21]}});S = S.processData(F,1107);
F = F.setProperty('parameters',{23,{[21 24]}});S = S.processData(F,1107);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{24,{[21 22 23]}});S = S.processData(F,1109);

F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1112);

F = F.setProperty('parameters',{10,{[5 7 9 12]}});S = S.processData(F,1113);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1113);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1113);

F = F.setProperty('parameters',{23,{[18 20 21 24]}});S = S.processData(F,1114);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1115);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1115);

F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1116);
F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1116);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1117);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1117);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1118);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1120);
F = F.setProperty('parameters',{7,{[2 4 5 9 10 12]}});S = S.processData(F,1120);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{7,{[2 4 5 9 10 12]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1122);

F = F.setProperty('parameters',{28,{[27 32 33 37]}});S = S.processData(F,1123);
F = F.setProperty('parameters',{36,{[31 32 40 41]}});S = S.processData(F,1123);

F = F.setProperty('parameters',{18,{[15 16 21 23]}});S = S.processData(F,1124);
F = F.setProperty('parameters',{20,{[15 21 23]}});S = S.processData(F,1124);
F = F.setProperty('parameters',{24,{[19 21 22 23]}});S = S.processData(F,1124);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1125);

F = F.setProperty('parameters',{28,{[27 32 33 37]}});S = S.processData(F,1127);

F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1128);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1129);

F = F.setProperty('parameters',{28,{[27 33 37]}});S = S.processData(F,1131);
F = F.setProperty('parameters',{32,{[27 31 33 36 37]}});S = S.processData(F,1131);

F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1132);

F = F.setProperty('parameters',{21,{[18 19 23 24]}});S = S.processData(F,1133);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1133);

F = F.setProperty('parameters',{7,{[2 4 5 9 10 12]}});S = S.processData(F,1135);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1135);
F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1135);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1136);
F = F.setProperty('parameters',{7,{[2 4 5 9 10 12]}});S = S.processData(F,1136);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1136);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1136);

F = F.setProperty('parameters',{6,{[1 3 4 8 11]}});S = S.processData(F,1137);
F = F.setProperty('parameters',{7,{[2 4 5 10 12]}});S = S.processData(F,1137);
F = F.setProperty('parameters',{9,{[8 10 11 12]}});S = S.processData(F,1137);
F = F.setProperty('parameters',{24,{[19 21 22 23]}});S = S.processData(F,1137);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1138);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1139);
F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1139);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1140);
F = F.setProperty('parameters',{32,{[27 28 31 33 36 37]}});S = S.processData(F,1140);

F = F.setProperty('parameters',{7,{[2 4 5 9 10 12]}});S = S.processData(F,1141);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1141);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1142);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1142);

F = F.setProperty('parameters',{20,{[15 18 21 23]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{23,{[19 20 21 24]}});S = S.processData(F,1143);


% ctrl2
F = NirsDataFunctor(); % clear output 
F = F.setProperty('function_handle',@NAfilt.interpolateChannel);
F = F.setProperty('input_names',{'CTL2.cui', 'CTL2.Deoxy'}); 

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1001);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1001);

F = F.setProperty('parameters',{23,{[20 21 24]}});S = S.processData(F,1002);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1002);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1005);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1006);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1006);

F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1007);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{26,{[25 30 31]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{27,{[28 31 32]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{36,{[31 32 40 41]}});S = S.processData(F,1008);

F = F.setProperty('parameters',{20,{[15 18 21]}});S = S.processData(F,1009);
F = F.setProperty('parameters',{23,{[18 21 24]}});S = S.processData(F,1009);

F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1011);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1013);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1013);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1014);

F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1015);
F = F.setProperty('parameters',{25,{[29 30 34]}});S = S.processData(F,1015);
F = F.setProperty('parameters',{26,{[27 30]}});S = S.processData(F,1015);
F = F.setProperty('parameters',{31,{[27 35 36]}});S = S.processData(F,1015);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1016);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1017);

F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1018);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1018);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1019);

F = F.setProperty('parameters',{9,{[6 7 11]}});S = S.processData(F,1020);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1020);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1020);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1021);
F = F.setProperty('parameters',{28,{[27 32 33]}});S = S.processData(F,1021);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1021);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1021);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1023);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1023);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{11,{[8 9 12]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{24,{[21 22 23]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1024);

F = F.setProperty('parameters',{21,{[18 19 24]}});S = S.processData(F,1025);
F = F.setProperty('parameters',{23,{[18 20 24]}});S = S.processData(F,1025);
F = F.setProperty('parameters',{28,{[27 32 33]}});S = S.processData(F,1025);

F = F.setProperty('parameters',{27,{[26 28 31 32]}});S = S.processData(F,1028);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1029);
F = F.setProperty('parameters',{31,{[26 27 35]}});S = S.processData(F,1029);
F = F.setProperty('parameters',{32,{[27 28 37]}});S = S.processData(F,1029);
F = F.setProperty('parameters',{36,{[35 37 40 41]}});S = S.processData(F,1029);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1031);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1032);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1033);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1034);
F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1034);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1035);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1035);

F = F.setProperty('parameters',{31,{[26 27 40]}});S = S.processData(F,1036);
F = F.setProperty('parameters',{35,{[30 39 40]}});S = S.processData(F,1036);
F = F.setProperty('parameters',{36,{[32 40 41]}});S = S.processData(F,1036);

F = F.setProperty('parameters',{10,{[5 7 12]}});S = S.processData(F,1037);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1037);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1037);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1039);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1039);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1041);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1042);
F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1042);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1042);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1043);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1043);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1044);
F = F.setProperty('parameters',{28,{[27 32 33]}});S = S.processData(F,1044);

F = F.setProperty('parameters',{26,{[25 27 30]}});S = S.processData(F,1046);
F = F.setProperty('parameters',{31,{[27 35 36]}});S = S.processData(F,1046);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1047);
F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1047);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1048);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1048);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1048);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1049);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1049);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1049);

F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1050);

F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1051);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1052);
F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1052);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1055);
F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1055);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1055);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1055);
F = F.setProperty('parameters',{25,{[26 29 30]}});S = S.processData(F,1055);

F = F.setProperty('parameters',{18,{[15 16 20]}});S = S.processData(F,1056);
F = F.setProperty('parameters',{19,{[16 17 22]}});S = S.processData(F,1056);

F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1101);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1102);
F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1102);

F = F.setProperty('parameters',{7,{[2 4 5 9 10 12]}});S = S.processData(F,1103);

F = F.setProperty('parameters',{7,{[2 4 5 9 10 12]}});S = S.processData(F,1104);
F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1104);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1107);
F = F.setProperty('parameters',{28,{[27 32 33 37]}});S = S.processData(F,1107);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1109);
F = F.setProperty('parameters',{24,{[19 21 22 23]}});S = S.processData(F,1109);

F = F.setProperty('parameters',{7,{[2 4 5 9 10 12]}});S = S.processData(F,1111);
F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1111);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1113);
F = F.setProperty('parameters',{19,{[14 16 17 21 22 24]}});S = S.processData(F,1113);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1117);
F = F.setProperty('parameters',{19,{[14 16 17 21 22 24]}});S = S.processData(F,1117);

F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1118);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1119);
F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1119);
F = F.setProperty('parameters',{35,{[30 31 39 40]}});S = S.processData(F,1119);

F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1120);
F = F.setProperty('parameters',{35,{[30 31 39 40]}});S = S.processData(F,1120);

F = F.setProperty('parameters',{12,{[7 9 10 11]}});S = S.processData(F,1121);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1122);

F = F.setProperty('parameters',{10,{[5 7 9 12]}});S = S.processData(F,1123);
F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1123);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1124);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1125);

F = F.setProperty('parameters',{28,{[27 32 33 37]}});S = S.processData(F,1127);

F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1128);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1129);
F = F.setProperty('parameters',{19,{[14 16 17 21 22 24]}});S = S.processData(F,1129);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1130);
F = F.setProperty('parameters',{7,{[2 4 5 9 10 12]}});S = S.processData(F,1130);
F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1130);
F = F.setProperty('parameters',{19,{[14 16 17 21 22 24]}});S = S.processData(F,1130);

F = F.setProperty('parameters',{11,{[6 8 9 12]}});S = S.processData(F,1131);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1132);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1133);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1135);
F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1135);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1136);
F = F.setProperty('parameters',{7,{[2 4 5 9 10 12]}});S = S.processData(F,1136);
F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1136);
F = F.setProperty('parameters',{19,{[14 16 17 21 22 24]}});S = S.processData(F,1136);

F = F.setProperty('parameters',{7,{[2 4 5 12]}});S = S.processData(F,1137);
F = F.setProperty('parameters',{9,{[6 8 11 12]}});S = S.processData(F,1137);
F = F.setProperty('parameters',{10,{[5 12]}});S = S.processData(F,1137);
F = F.setProperty('parameters',{20,{[15 18 21 23]}});S = S.processData(F,1137);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1138);

F = F.setProperty('parameters',{25,{[26 29 30 34]}});S = S.processData(F,1139);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1140);
F = F.setProperty('parameters',{19,{[14 16 17 21 22 24]}});S = S.processData(F,1140);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1141);
F = F.setProperty('parameters',{7,{[2 4 5 9 10 12]}});S = S.processData(F,1141);
F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1141);
F = F.setProperty('parameters',{32,{[13 15 16 20 21 23]}});S = S.processData(F,1141);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1142);
F = F.setProperty('parameters',{19,{[14 16 17 21 22 24]}});S = S.processData(F,1142);

F = F.setProperty('parameters',{6,{[1 3 4 8 11]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{7,{[2 4 5 12]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{9,{[6 8 11 12]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{10,{[5 12]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1143);


% arith
F = NirsDataFunctor(); % clear output 
F = F.setProperty('function_handle',@NAfilt.interpolateChannel);
F = F.setProperty('input_names',{'Arith.cui', 'Arith.Deoxy'}); 

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1001);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1001);

F = F.setProperty('parameters',{23,{[20 21 24]}});S = S.processData(F,1002);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1004);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1004);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1005);

F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1006);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1006);

F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1007);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1007);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1008);
F = F.setProperty('parameters',{36,{[31 32 40 41]}});S = S.processData(F,1008);

F = F.setProperty('parameters',{10,{[5 7 12]}});S = S.processData(F,1010);

F = F.setProperty('parameters',{18,{[15 16 20]}});S = S.processData(F,1011);
F = F.setProperty('parameters',{21,{[19 23 24]}});S = S.processData(F,1011);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1012);

F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1013);
F = F.setProperty('parameters',{36,{[31 32 40 41]}});S = S.processData(F,1013);

F = F.setProperty('parameters',{10,{[5 7 9]}});S = S.processData(F,1014);
F = F.setProperty('parameters',{12,{[7 9 11]}});S = S.processData(F,1014);

F = F.setProperty('parameters',{25,{[29 30 34]}});S = S.processData(F,1015);
F = F.setProperty('parameters',{26,{[27 30 31]}});S = S.processData(F,1015);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1016);
F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1016);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1017);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1017);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1017);

F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1018);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1019);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1019);

F = F.setProperty('parameters',{9,{[6 7 11 12]}});S = S.processData(F,1020);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1020);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1020);

F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1021);

F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1022);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1023);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1023);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1023);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{24,{[21 22 23]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{28,{[27 32 33]}});S = S.processData(F,1024);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1024);

F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1025);

F = F.setProperty('parameters',{27,{[26 28 31 32]}});S = S.processData(F,1028);

F = F.setProperty('parameters',{32,{[27 28 37]}});S = S.processData(F,1029);
F = F.setProperty('parameters',{36,{[35 37 40 41]}});S = S.processData(F,1029);

F = F.setProperty('parameters',{18,{[15 16 20]}});S = S.processData(F,1030);
F = F.setProperty('parameters',{19,{[16 17 22]}});S = S.processData(F,1030);
F = F.setProperty('parameters',{21,{[20 22 23 24]}});S = S.processData(F,1030);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1032);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1033);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1033);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1034);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1034);

F = F.setProperty('parameters',{10,{[5 7 12]}});S = S.processData(F,1037);
F = F.setProperty('parameters',{18,{[15 16 21]}});S = S.processData(F,1037);
F = F.setProperty('parameters',{20,{[15 21]}});S = S.processData(F,1037);
F = F.setProperty('parameters',{23,{[21 24]}});S = S.processData(F,1037);

F = F.setProperty('parameters',{10,{[5 7 12]}});S = S.processData(F,1038);
F = F.setProperty('parameters',{20,{[15 18 23]}});S = S.processData(F,1038);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1039);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1041);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1041);

F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1042);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1042);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1042);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1043);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1043);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1044);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1044);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1044);
F = F.setProperty('parameters',{32,{[27 28 36 37]}});S = S.processData(F,1044);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1046);
F = F.setProperty('parameters',{31,{[26 27 35 36]}});S = S.processData(F,1046);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1048);
F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1048);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1048);
F = F.setProperty('parameters',{19,{[16 17 21 22]}});S = S.processData(F,1048);
F = F.setProperty('parameters',{30,{[25 26 34 35]}});S = S.processData(F,1048);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1051);

F = F.setProperty('parameters',{6,{[3 4 8 9]}});S = S.processData(F,1052);
F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1052);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1055);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1055);

F = F.setProperty('parameters',{18,{[15 16 20]}});S = S.processData(F,1056);
F = F.setProperty('parameters',{19,{[16 17 22]}});S = S.processData(F,1056);
F = F.setProperty('parameters',{21,{[20 22 23 24]}});S = S.processData(F,1056);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1101);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1101);

F = F.setProperty('parameters',{7,{[2 4 5 9 12]}});S = S.processData(F,1102);
F = F.setProperty('parameters',{10,{[5 9 12]}});S = S.processData(F,1102);
F = F.setProperty('parameters',{21,{[18 19 20 22 23 24]}});S = S.processData(F,1102);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1103);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1103);

F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1104);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1106);
F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1106);

F = F.setProperty('parameters',{20,{[15 18 21 23]}});S = S.processData(F,1107);
F = F.setProperty('parameters',{30,{[25 26 29 35 36]}});S = S.processData(F,1107);
F = F.setProperty('parameters',{31,{[26 27 32 35 36]}});S = S.processData(F,1107);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1108);

F = F.setProperty('parameters',{18,{[15 16 20 21]}});S = S.processData(F,1109);

F = F.setProperty('parameters',{30,{[25 26 29 35 36]}});S = S.processData(F,1111);
F = F.setProperty('parameters',{31,{[26 27 32 35 36]}});S = S.processData(F,1111);

F = F.setProperty('parameters',{30,{[25 26 29 35 36]}});S = S.processData(F,1112);
F = F.setProperty('parameters',{31,{[26 27 32 35 36]}});S = S.processData(F,1112);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1113);
F = F.setProperty('parameters',{19,{[14 16 17 21 22 24]}});S = S.processData(F,1113);

F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1114);

F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1116);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1119);
F = F.setProperty('parameters',{19,{[14 16 17 21 22 24]}});S = S.processData(F,1119);
F = F.setProperty('parameters',{32,{[27 28 31 33 36 37]}});S = S.processData(F,1119);

F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1120);

F = F.setProperty('parameters',{9,{[6 7 8 10 11 12]}});S = S.processData(F,1122);
F = F.setProperty('parameters',{26,{[25 27 30 31]}});S = S.processData(F,1122);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1123);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1124);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1125);

F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1128);

F = F.setProperty('parameters',{19,{[14 16 17 21 22 24]}});S = S.processData(F,1130);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1131);
F = F.setProperty('parameters',{36,{[31 32 35 37 40 41]}});S = S.processData(F,1131);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1132);
F = F.setProperty('parameters',{31,{[26 27 30 32 35 36]}});S = S.processData(F,1132);

F = F.setProperty('parameters',{18,{[13 15 16 20 23]}});S = S.processData(F,1133);
F = F.setProperty('parameters',{19,{[14 16 17 22 24]}});S = S.processData(F,1133);
F = F.setProperty('parameters',{21,{[20 22 23 24]}});S = S.processData(F,1133);
F = F.setProperty('parameters',{30,{[25 26 29 31 34 35]}});S = S.processData(F,1133);

F = F.setProperty('parameters',{18,{[13 15 16 20 23]}});S = S.processData(F,1135);
F = F.setProperty('parameters',{31,{[26 27 30 32 35]}});S = S.processData(F,1135);
F = F.setProperty('parameters',{36,{[32 35 37 40 41]}});S = S.processData(F,1135);

F = F.setProperty('parameters',{7,{[4 5 9 10]}});S = S.processData(F,1136);

F = F.setProperty('parameters',{24,{[19 21 22 23]}});S = S.processData(F,1137);

F = F.setProperty('parameters',{18,{[13 15 16 20 23]}});S = S.processData(F,1140);

F = F.setProperty('parameters',{6,{[1 3 4 8 9 11]}});S = S.processData(F,1141);
F = F.setProperty('parameters',{7,{[2 4 5 9 10 12]}});S = S.processData(F,1141);
F = F.setProperty('parameters',{18,{[13 15 16 20 23]}});S = S.processData(F,1141);
F = F.setProperty('parameters',{31,{[26 27 30 35 36]}});S = S.processData(F,1141);
F = F.setProperty('parameters',{32,{[27 28 33 36 37]}});S = S.processData(F,1141);

F = F.setProperty('parameters',{18,{[13 15 16 20 21 23]}});S = S.processData(F,1142);
F = F.setProperty('parameters',{19,{[14 16 17 21 22 24]}});S = S.processData(F,1142);

F = F.setProperty('parameters',{18,{[13 15 16 20 23]}});S = S.processData(F,1143);
F = F.setProperty('parameters',{21,{[20 22 23 24]}});S = S.processData(F,1143);


%% Kernelfilter to eliminate the global component (systemic physiological artifacts): PCAGLOBAL(X, sigma)

 for x=1:size(Bedingungen,1)
 S = S.processData(NirsDataFunctor('function_handle',@(X) pcaglobal2(X,46,[1:46]),'input_names',{(Bedingungen{x})}));
 end

Bedingungen3={'CTL1.Deoxy';'CTL2.Deoxy';'Arith.Deoxy'};

for x=1:size(Bedingungen3,1)
 S = S.processData(NirsDataFunctor('function_handle',@(X) pcaglobal2(X,46,[1:46]),'input_names',{(Bedingungen3{x})}));
 end

% NIRS Data Z-Transform for comparison between subjects
 
 for x=1:size(Bedingungen,1)
     S = S.processData(NirsDataFunctor('function_handle',@(X)NIRSZStandard(X),'input_names',{(Bedingungen{x})}));
 end

 for x=1:size(Bedingungen3,1)
     S = S.processData(NirsDataFunctor('function_handle',@(X)NIRSZStandard(X),'input_names',{(Bedingungen3{x})}));
 end



%% settings 

clear settings P PS;
P = NirsPlotTool();

settings.experiment.time_series{1} = {'name','CTL1.cui','sample_rate',10,'trigger_name','CTL1.trigger'};
settings.experiment.time_series{2} = {'name','CTL2.cui','sample_rate',10,'trigger_name','CTL2.trigger'};
settings.experiment.time_series{3} = {'name','Arith.cui','sample_rate',10,'trigger_name','Stress.trigger'};
settings.experiment.time_series{4} = {'name','CTL1.Deoxy','sample_rate',10,'trigger_name','CTL1.trigger'};
settings.experiment.time_series{5} = {'name','CTL2.Deoxy','sample_rate',10,'trigger_name','CTL2.trigger'};
settings.experiment.time_series{6} = {'name','Arith.Deoxy','sample_rate',10,'trigger_name','Stress.trigger'};

settings.experiment.category{1} = {'name','TriggerA','trigger_token',1}; % for analysis of window 3
% settings.experiment.category{1} = {'name','TriggerA','trigger_token',9}; % for analysis of window 1 and window 2

P = P.setProperties(settings);   
P = NirsPlotTool();
P = P.setProperty('show_probeset','on');
P = P.setProperties(settings);

PS = NirsProbeset('brain_coord_file','Q:\NAS\Ehlis_Auswertung\Laufwerk_S\\AG-Mitglieder\David\Studie Stress Rumination\Koords\NIRS-probesetXYZ_Alle2.txt');
settings.plot_tool.probesets{1} = {'name','Gesamt','probeset',PS};

P = P.setProperties(settings);
P = P.setProperty('probesets',{'name','Gesamt','probeset',PS});

P = P.setProperties(settings);   

P = P.setProperty('show_probeset','on');
P = P.setProperties(settings);

Subject=S.tags(1)

%% data export 

% EXPORT 1: 15 Sekunden vor Trigger 1 Zeitraum
% clear ERA
% settings.event_related_average.pre_time = 5; % Sekunden Baseline Correction
% settings.event_related_average.linear_detrend = 'off'; 
% settings.event_related_average.interval = [0 55];  
% settings.event_related_average.peak_window = [5 40]; 
% settings.event_related_average.average_window = [0 15]; 

% % EXPORT 2: von Trigger 1 bis Trigger 4 Zeitraum
% clear ERA
% settings.event_related_average.pre_time = 5; % Sekunden Baseline Correction
% settings.event_related_average.linear_detrend = 'off';
% settings.event_related_average.interval = [0 55]; 
% settings.event_related_average.peak_window = [5 40];  
% settings.event_related_average.average_window = [15 55]; 

% EXPORT 3: in Einstellungen wieder Trigger 1 als relevanten Trigger setzen
clear ERA
settings.event_related_average.pre_time = 5; % Sekunden Baseline Correction
settings.event_related_average.linear_detrend = 'off'; 
settings.event_related_average.interval = [0 55]; 
settings.event_related_average.peak_window = [5 40]; % 5 40
settings.event_related_average.average_window = [0 40]; 


ERA = NirsEventRelatedAverage();
ERA = ERA.setProperties(settings);
ERA = ERA.createEra(S);

%% 
clear Data Data2
for i=1:size(Subject,1)
    Data.AvgArith(:,:,i) = ERA.get({'era.avg','Arith.cui','TriggerA',Subject{i}});
    Data.AmpArith(:,i) = ERA.get({'amplitudes','Arith.cui','TriggerA',Subject{i}});
    Data.AvgCTL1(:,:,i) = ERA.get({'era.avg','CTL1.cui','TriggerA',Subject{i}});
    Data.AmpCTL1(:,i) = ERA.get({'amplitudes','CTL1.cui','TriggerA',Subject{i}});
    Data.AvgCTL2(:,:,i) = ERA.get({'era.avg','CTL2.cui','TriggerA',Subject{i}});
    Data.AmpCTL2(:,i) = ERA.get({'amplitudes','CTL2.cui','TriggerA',Subject{i}});
end

dat1=Data.AmpArith'
dat2= Data.AmpCTL1'
dat3=Data.AmpCTL2'

dat=[dat1,dat2,dat3]


for i=1:size(Subject,1)
    Data2.AvgArith(:,:,i) = ERA.get({'era.avg','Arith.Deoxy','TriggerA',Subject{i}});
    Data2.AmpArith(:,i) = ERA.get({'amplitudes','Arith.Deoxy','TriggerA',Subject{i}});
    Data2.AvgCTL1(:,:,i) = ERA.get({'era.avg','CTL1.Deoxy','TriggerA',Subject{i}});
    Data2.AmpCTL1(:,i) = ERA.get({'amplitudes','CTL1.Deoxy','TriggerA',Subject{i}});
    Data2.AvgCTL2(:,:,i) = ERA.get({'era.avg','CTL2.Deoxy','TriggerA',Subject{i}});
    Data2.AmpCTL2(:,i) = ERA.get({'amplitudes','CTL2.Deoxy','TriggerA',Subject{i}});
end

dat1=Data2.AmpArith'
dat2= Data2.AmpCTL1'
dat3=Data2.AmpCTL2'

dat=[dat1,dat2,dat3]

clear Daten
Array(:,1)= cell2mat(Subject)
Array(:,2)=nanmean(Data2.AmpArith(lIFG,:),1) %left IFG
Array(:,3)=nanmean(Data2.AmpArith(lDLPFC,:),1) % left DLPFC
Array(:,4)=nanmean(Data2.AmpArith(rIFG,:),1) %right IFG
Array(:,5)=nanmean(Data2.AmpArith(rDLPFC,:),1) %right DLPFC
Array(:,6)=nanmean(Data2.AmpArith(SAC,:),1)

Array(:,7)=nanmean(Data2.AmpCTL1(lIFG,:),1) %left IFG
Array(:,8)=nanmean(Data2.AmpCTL1(lDLPFC,:),1) % left DLPFC
Array(:,9)=nanmean(Data2.AmpCTL1(rIFG,:),1) %right IFG
Array(:,10)=nanmean(Data2.AmpCTL1(rDLPFC,:),1) %right DLPFC
Array(:,11)=nanmean(Data2.AmpCTL1(SAC,:),1)

Array(:,12)=nanmean(Data2.AmpCTL2(lIFG,:),1) %left IFG
Array(:,13)=nanmean(Data2.AmpCTL2(lDLPFC,:),1) % left DLPFC
Array(:,14)=nanmean(Data2.AmpCTL2(rIFG,:),1) %right IFG
Array(:,15)=nanmean(Data2.AmpCTL2(rDLPFC,:),1) %right DLPFC
Array(:,16)=nanmean(Data2.AmpCTL2(SAC,:),1)

Daten = array2table(Array, 'VariableNames',{'Subject',...
    'Arith_lIFG_Deoxy', 'Arith_lDLPFC_Deoxy','Arith_rIFG_Deoxy', 'Arith_rDLPFC_Deoxy','Arith_SAC_Deoxy',...
    'CTL1_lIFG_Deoxy', 'CTL1_lDLPFC_Deoxy','CTL1_rIFG_Deoxy', 'CTL1_rDLPFC_Deoxy','CTL1_SAC_Deoxy',...
    'CTL2_lIFG_Deoxy', 'CTL2_lDLPFC_Deoxy','CTL2_rIFG_Deoxy', 'CTL2_rDLPFC_Deoxy','CTL2_SAC_Deoxy'});
% writetable(Daten,'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Preprocessing_Matlab\2026_01_27_NIRS_TSST-Anticipation_Export1_0bis15s_deoxy.xlsx')
% writetable(Daten,'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Preprocessing_Matlab\2026_01_27_NIRS_TSST-Anticipation_Export2_15bis55s_deoxy.xlsx')
writetable(Daten,'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Preprocessing_Matlab\2026_04_08_NIRS_TSST-Anticipation_Export3_0bis40s_deoxy.xlsx')


%%

lIFG=[7 9 6]
lDLPFC=[10 11 12]
rIFG=[ 18 21 19]
rDLPFC=[20 23 24]
SAC=[27 26 25 28 30 31 32 35 36]

%% OXY 

clear Data Data2
for i=1:size(Subject,1)
    Data.AvgArith(:,:,i) = ERA.get({'era.avg','Arith.cui','TriggerA',Subject{i}});
    Data.AmpArith(:,i) = ERA.get({'amplitudes','Arith.cui','TriggerA',Subject{i}});
    Data.AvgCTL1(:,:,i) = ERA.get({'era.avg','CTL1.cui','TriggerA',Subject{i}});
    Data.AmpCTL1(:,i) = ERA.get({'amplitudes','CTL1.cui','TriggerA',Subject{i}});
    Data.AvgCTL2(:,:,i) = ERA.get({'era.avg','CTL2.cui','TriggerA',Subject{i}});
    Data.AmpCTL2(:,i) = ERA.get({'amplitudes','CTL2.cui','TriggerA',Subject{i}});
end

dat1=Data.AmpArith'
dat2= Data.AmpCTL1'
dat3=Data.AmpCTL2'

dat=[dat1,dat2,dat3]

clear Daten
Array(:,1)= cell2mat(Subject)
Array(:,2)=mean(Data.AmpArith(lIFG,:),1) %left IFG
Array(:,3)=mean(Data.AmpArith(lDLPFC,:),1) % left DLPFC
Array(:,4)=mean(Data.AmpArith(rIFG,:),1) %right IFG
Array(:,5)=mean(Data.AmpArith(rDLPFC,:),1) %right DLPFC
Array(:,6)=mean(Data.AmpArith(SAC,:),1)

Array(:,7)=mean(Data.AmpCTL1(lIFG,:),1) %left IFG
Array(:,8)=mean(Data.AmpCTL1(lDLPFC,:),1) % left DLPFC
Array(:,9)=mean(Data.AmpCTL1(rIFG,:),1) %right IFG
Array(:,10)=mean(Data.AmpCTL1(rDLPFC,:),1) %right DLPFC
Array(:,11)=mean(Data.AmpCTL1(SAC,:),1)

Array(:,12)=mean(Data.AmpCTL2(lIFG,:),1) %left IFG
Array(:,13)=mean(Data.AmpCTL2(lDLPFC,:),1) % left DLPFC
Array(:,14)=mean(Data.AmpCTL2(rIFG,:),1) %right IFG
Array(:,15)=mean(Data.AmpCTL2(rDLPFC,:),1) %right DLPFC
Array(:,16)=mean(Data.AmpCTL2(SAC,:),1)

Daten = array2table(Array, 'VariableNames',{'Subject',...
    'Arith_lIFG_Cui', 'Arith_lDLPFC_Cui','Arith_rIFG_Cui', 'Arith_rDLPFC_Cui','Arith_SAC_Cui',...
    'CTL1_lIFG_Cui', 'CTL1_lDLPFC_Cui','CTL1_rIFG_Cui', 'CTL1_rDLPFC_Cui','CTL1_SAC_Cui',...
    'CTL2_lIFG_Cui', 'CTL2_lDLPFC_Cui','CTL2_rIFG_Cui', 'CTL2_rDLPFC_Cui','CTL2_SAC_Cui'});
% writetable(Daten,'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Preprocessing_Matlab\2026_04_08_NIRS_TSST-Anticipation_Export1_0bis15s_only1trial.xlsx')
% writetable(Daten,'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Preprocessing_Matlab\2026_04_08_NIRS_TSST-Anticipation_Export2_15bis55s_only1trial.xlsx')
writetable(Daten,'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Preprocessing_Matlab\2026_04_08_NIRS_TSST-Anticipation_Export3_0bis40s_only1trial.xlsx')


%% export for brainmaps 
save 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\PlotsData_Export3_trial1.mat' Data
save 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\PlotsSubjects_Export3_trial1.mat' Subject

% %% Time series Illustration ERA: TSST 
% 
% YLIMITS   = [-0.9 1.2];
% XLIMITS   = [-25 62];
% LEG_POS   = [0.05, 0.75, 0.3, 0.1];
% FONT_SZ   = 14;
% LEG_FS    = 12;
% 
% % --- Subplot-Konfiguration (nur ein Kanal/Subplot) ---
% subplotList = {
%     lIFG, ' '
% };
% 
% % --- Farben für Gruppen --- hexColor1 = '#00676f'; rgbColor1 =
% % sscanf(hexColor1(2:end), '%2x%2x%2x', [1 3]) / 255;
% hexColor1 = '#9b7b00'; rgbColor1 = sscanf(hexColor1(2:end), '%2x%2x%2x', [1 3]) / 255; 
% % hexColor1 = '#b43602'; rgbColor1 = sscanf(hexColor1(2:end), '%2x%2x%2x',
% % [1 3]) / 255;
% 
% % --- Figure setup (Querformat DINA4) ---
% close all
% figure
% set(gcf,'Units','inches','Position',[1 1 11.69 8.27])  % Breite x Höhe in inches
% 
% % --- Zeitachse --- t = (-199:(size(Data.AvgArith,1)-200))'/10; % 20
% % Sekunden baseline
% t = (-49:(size(Data.AvgArith,1)-50))'/10; % 5 sekunden baseline
% 
% % --- Ein Subplot, volle Fläche ---
% ax = axes('Position',[0.07 0.15 0.9 0.75]);  % links, unten, Breite, Höhe (normiert)
% hold(ax,'on')
% 
% % --- Hintergrund-Patches ---
% trialPatch = patch([0 40 40 0], [-1 -1 2 2], [0.95 0.95 0.95], ...
%     'EdgeColor','none', 'DisplayName','trial');
% pausePatch = patch([40 60 60 40], [-1 -1 2 2], [0.85 0.85 0.85], ...
%     'EdgeColor','none', 'DisplayName','pause');
% 
% % --- Daten plotten ---
% chn   = subplotList{1,1};
% TITLE = subplotList{1,2};
% 
% % Mittelung über alle Subjects
% dat = squeeze(mean(Data.AvgArith(:,chn,:),2));          % Mittelung über Kanäle
% SEM = std(dat,0,2) ./ sqrt(size(Data.AvgArith,3));      % SEM über Subjects
% timeseries = mean(dat,2);                               % Mittelwert über Subjects
% 
% % SEM als transparenten Patch
% xPatch = [t; flipud(t)];
% yPatch = [timeseries-SEM; flipud(timeseries+SEM)];
% hPatch = fill(xPatch, yPatch, rgbColor1, 'FaceAlpha', 0.15, 'EdgeColor', 'none', 'DisplayName','fNIRS data');
% 
% % Mittelwert-Zeitreihe
% hLine = plot(t, timeseries, '.-', 'Color', rgbColor1, 'LineWidth',1.5, 'DisplayName','fNIRS data window 2');
% 
% xticks(XLIMITS(1):5:XLIMITS(2))
% 
% % --- Achsen, Labels, Titel ---
% ylim(YLIMITS)
% xlim(XLIMITS)
% xlabel('time in s','FontSize',FONT_SZ,'FontWeight','bold')
% ylabel('z','FontSize',FONT_SZ,'FontWeight','bold')
% title(TITLE,'FontSize',FONT_SZ,'FontWeight','bold')
% set(ax, 'FontSize', 14)   % z.B. 14 Punkt für Tick-Beschriftungen
% 
% % --- Legende ---
% lh = legend([trialPatch pausePatch hLine], 'Location','northoutside'); % oder legend([trialPatch pausePatch hLine])
% legend boxoff 
% set(lh,'FontSize',LEG_FS,'FontWeight','bold')
% set(lh,'Units','normalized','Position',LEG_POS)
% set(lh,'Color','none');       %  Hintergrund
% set(lh,'EdgeColor','none');   % Rahmen
% set(lh,'Box','off');          % Kasten 
% 
% hold off
% 
% %% nur fNIRS Zeitreihe, alles andere unsichtbar 
% 
% YLIMITS   = [-0.9 1.2];
% XLIMITS   = [-25 62];
% LEG_POS   = [0.05 0.75 0.3 0.1];
% LEG_FS    = 14;
% 
% % --- Farbe ---
% hexColor1 = '#00676f';
% rgbColor1 = sscanf(hexColor1(2:end), '%2x%2x%2x', [1 3]) / 255;
% 
% % --- Figure setup (alles gleich groß wie vorher) ---
% close all
% figure
% set(gcf,'Units','inches','Position',[1 1 11.69 8.27])
% 
% % --- Zeitachse ---
% t = (-49:(size(Data.AvgArith,1)-50))'/10;
% 
% % --- Achse ---
% ax = axes('Position',[0.07 0.15 0.9 0.75]);
% hold(ax,'on')
% 
% % --- Daten ---
% dat = squeeze(mean(Data.AvgArith(:,lIFG,:),2));
% timeseries = mean(dat,2);
% 
% % --- Zeitreihe (sichtbar im Plot) ---
% plot(t, timeseries, '.-', ...
%     'Color', rgbColor1, ...
%     'LineWidth', 1.5, ...
%     'MarkerSize', 10, ...
%     'HandleVisibility','off');
% 
% % --- Proxy-Objekt NUR für Legende ---
% hLeg = plot(nan, nan, '.-', ...
%     'Color', rgbColor1, ...
%     'LineWidth', 1.5, ...
%     'MarkerSize', 16, ...
%     'DisplayName','fNIRS data');
% 
% % --- Limits setzen (wirksam, aber unsichtbar) ---
% xlim(XLIMITS)
% ylim(YLIMITS)
% 
% % --- ALLES ausblenden außer Linie ---
% axis off
% set(ax,'Color','none')   % transparenter Hintergrund
% 
% % --- Legende (nur Zeitreihe) ---
% lh = legend(hLeg);
% set(lh,'FontSize',LEG_FS,'FontWeight','bold')
% set(lh,'Units','normalized','Position',LEG_POS)
% set(lh,'Color','none','EdgeColor','none','Box','off')
% 
% hold off
% 
% %% Dateiname ohne Erweiterung
% filename = 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Plots\FigureX_Illustration_window2';
% 
% % Speichern als .svg
% print(gcf, filename, '-dsvg', '-r600');


%% Time series HC vs. DP all ROIs: TSST (Export 3)
clear all
clc
lIFG=[7 9 6];
lDLPFC=[10 12 11];
rIFG=[18 21 19];
rDLPFC=[20 23 24];
SAC=[27 26 25 28 30 31 32 35 36];
load('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\Data_Export3.mat');
load('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\Subjects_Export3.mat');

lineV       = @(x,spec) plot(repmat(x(:),1,2)',repmat(ylim,numel(x),1)',spec{:}); 
toPatch     = @(x1,x2,y1,y2,spec) patch([x1(:);flipud(repmat(x2(:),numel(x1)./numel(x2),1))],[y1(:);flipud(repmat(y2(:),numel(y1)./numel(y2),1))],spec{:}); 
colors = get(groot,'defaultAxesColorOrder');
test = Subject;
Group1 = [56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 105 106 108 109 110 111 116 118 120 121 122 123 124 125 126 127 132 ]; % HC 
Group2 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 104 107 112 113 114 115 117 119 128 129 130 131 133 134 135 136 137 138 139 140 141 142 ]; % DP 

YLIMITS   = [-0.9 1.2];
XLIMITS   = [-25 42]; 
LEG_POS   = [0.62, 0.05, 0.32, 0.18];   % unten rechts
FONT_SZ   = 8;
LEG_FS    = 6;

% --- Subplot-Konfiguration ---
subplotList = {
    lIFG,   'left VLPFC',  1;
    rIFG,   'right VLPFC', 2;
    lDLPFC, 'left DLPFC',  3;
    rDLPFC, 'right DLPFC', 4;
    SAC,    'SAC',         5;
};

% --- Farben fuer Gruppen ---
hexColor1 = '#00676f'; rgbColor1 = sscanf(hexColor1(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor2 = '#9b7b00'; rgbColor2 = sscanf(hexColor2(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor3 = '#b43602'; rgbColor3 = sscanf(hexColor3(2:end), '%2x%2x%2x', [1 3]) / 255; 

% --- Figure setup ---
close all
figure
set(gcf,'Units','inches','Position',[1 1 8.27 6])

% --- Zeitachse ---
timeOffset = 0;              % kein offset bei Export3
t = (-49:(size(Data.AvgArith,1)-50))'/10 + timeOffset; 
lh = cell(size(subplotList,1),1);

% --- Loop ueber alle Subplots ---
for iPlot = 1:size(subplotList,1)
    chn   = subplotList{iPlot,1};
    TITLE = subplotList{iPlot,2};
    spID  = subplotList{iPlot,3};
    subplot(3,2,spID)
    
    % --- Hintergrund-Patches ---
    p1 = patch([0 40 40 0], [-1 -1 2 2], [0.95 0.95 0.95], ...
         'EdgeColor','none','DisplayName','trial'); 
    hold on
    p2 = patch([-5 0 0 -5], [-1 -1 2 2], [0.85 0.85 0.85], ...
         'EdgeColor','none','DisplayName','baseline');

    % --- Gruppe 1: HC ---
    dat = squeeze(mean(Data.AvgArith(:,chn,Group1),2)); 
    SEM = std(dat,0,2) ./ sqrt(numel(Group1));         
    timeseries = mean(dat,2);                           
    h1 = plot(t,timeseries,'.-','Color',rgbColor1,'DisplayName','HC');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor1,'facealpha',0.15})

    % --- Gruppe 2: DP ---
    dat = squeeze(mean(Data.AvgArith(:,chn,Group2),2));
    SEM = std(dat,0,2) ./ sqrt(numel(Group2));
    timeseries = mean(dat,2);
    h2 = plot(t,timeseries,'.-','Color',rgbColor2,'DisplayName','DP');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor2,'facealpha',0.15})

    % --- Achsen, Labels, Titel ---
    ylim(YLIMITS)
    xlim(XLIMITS)
    xlabel('time in s','FontSize',FONT_SZ,'FontWeight','bold')
    ylabel('z','FontSize',FONT_SZ,'FontWeight','bold')
    title(TITLE,'FontSize',FONT_SZ,'FontWeight','bold')

    % --- Legende ---
    lh{iPlot} = legend([p1 p2 h1 h2],'trial','baseline','HC','DP');
    legend boxoff 
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)

    % --- weisser Hintergrund ---
    lh{iPlot} = legend([p1 p2 h1 h2],'trial','baseline','HC','DP');
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)
    set(lh{iPlot}, 'Color', 'w');       % Weisser Hintergrund
    set(lh{iPlot}, 'EdgeColor', 'w');   % Rahmen
    set(lh{iPlot}, 'Box', 'on');        % Kasten sichtbar
    hold off
end

filename = 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\SupplementaryMaterial\FigureS6.3_Timeseries_DPvsHC_Arith_window3';

print(gcf, [filename '.svg'], '-dsvg', '-r600');
print(gcf, [filename '.jpg'], '-djpeg', '-r600');


%% Time series HC vs. DP all ROIs: CTL1 (Export 3)
lineV       = @(x,spec) plot(repmat(x(:),1,2)',repmat(ylim,numel(x),1)',spec{:}); 
toPatch     = @(x1,x2,y1,y2,spec) patch([x1(:);flipud(repmat(x2(:),numel(x1)./numel(x2),1))],[y1(:);flipud(repmat(y2(:),numel(y1)./numel(y2),1))],spec{:}); 
colors = get(groot,'defaultAxesColorOrder');
test = Subject;
Group1 = [56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 105 106 108 109 110 111 116 118 120 121 122 123 124 125 126 127 132 ]; % HC 
Group2 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 104 107 112 113 114 115 117 119 128 129 130 131 133 134 135 136 137 138 139 140 141 142 ]; % DP 

YLIMITS   = [-0.9 1.2];
XLIMITS   = [-25 42]; 
LEG_POS   = [0.62, 0.05, 0.32, 0.18];   % unten rechts
FONT_SZ   = 8;
LEG_FS    = 6;

% --- Subplot-Konfiguration ---
subplotList = {
    lIFG,   'left VLPFC',  1;
    rIFG,   'right VLPFC', 2;
    lDLPFC, 'left DLPFC',  3;
    rDLPFC, 'right DLPFC', 4;
    SAC,    'SAC',         5;
};

% --- Farben fuer Gruppen ---
hexColor1 = '#00676f'; rgbColor1 = sscanf(hexColor1(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor2 = '#9b7b00'; rgbColor2 = sscanf(hexColor2(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor3 = '#b43602'; rgbColor3 = sscanf(hexColor3(2:end), '%2x%2x%2x', [1 3]) / 255; 

% --- Figure setup ---
close all
figure
set(gcf,'Units','inches','Position',[1 1 8.27 6])

% --- Zeitachse ---
timeOffset = 0;              % kein offset bei Export3
t = (-49:(size(Data.AvgCTL1,1)-50))'/10 + timeOffset; 
lh = cell(size(subplotList,1),1);

% --- Loop ueber alle Subplots ---
for iPlot = 1:size(subplotList,1)
    chn   = subplotList{iPlot,1};
    TITLE = subplotList{iPlot,2};
    spID  = subplotList{iPlot,3};
    subplot(3,2,spID)
    
    % --- Hintergrund-Patches ---
    p1 = patch([0 40 40 0], [-1 -1 2 2], [0.95 0.95 0.95], ...
         'EdgeColor','none','DisplayName','trial'); 
    hold on
    p2 = patch([-5 0 0 -5], [-1 -1 2 2], [0.85 0.85 0.85], ...
         'EdgeColor','none','DisplayName','baseline');

    % --- Gruppe 1: HC ---
    dat = squeeze(mean(Data.AvgCTL1(:,chn,Group1),2)); 
    SEM = std(dat,0,2) ./ sqrt(numel(Group1));         
    timeseries = mean(dat,2);                           
    h1 = plot(t,timeseries,'.-','Color',rgbColor1,'DisplayName','HC');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor1,'facealpha',0.15})

    % --- Gruppe 2: DP ---
    dat = squeeze(mean(Data.AvgCTL1(:,chn,Group2),2));
    SEM = std(dat,0,2) ./ sqrt(numel(Group2));
    timeseries = mean(dat,2);
    h2 = plot(t,timeseries,'.-','Color',rgbColor2,'DisplayName','DP');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor2,'facealpha',0.15})

    % --- Achsen, Labels, Titel ---
    ylim(YLIMITS)
    xlim(XLIMITS)
    xlabel('time in s','FontSize',FONT_SZ,'FontWeight','bold')
    ylabel('z','FontSize',FONT_SZ,'FontWeight','bold')
    title(TITLE,'FontSize',FONT_SZ,'FontWeight','bold')

    % --- Legende ---
    lh{iPlot} = legend([p1 p2 h1 h2],'trial','baseline','HC','DP');
    legend boxoff 
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)

    % --- weisser Hintergrund ---
    lh{iPlot} = legend([p1 p2 h1 h2],'trial','baseline','HC','DP');
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)
    set(lh{iPlot}, 'Color', 'w');       % Weisser Hintergrund
    set(lh{iPlot}, 'EdgeColor', 'w');   % Rahmen
    set(lh{iPlot}, 'Box', 'on');        % Kasten sichtbar
    hold off
end

filename = 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\FigureX_Timeseries_DPvsHC_CTL1_window3';
print(gcf, [filename '.svg'], '-dsvg', '-r600');
print(gcf, [filename '.jpg'], '-djpeg', '-r600');



%% Time series HC vs. DP all ROIs: CTL2 (Export 3)
lineV       = @(x,spec) plot(repmat(x(:),1,2)',repmat(ylim,numel(x),1)',spec{:}); 
toPatch     = @(x1,x2,y1,y2,spec) patch([x1(:);flipud(repmat(x2(:),numel(x1)./numel(x2),1))],[y1(:);flipud(repmat(y2(:),numel(y1)./numel(y2),1))],spec{:}); 
colors = get(groot,'defaultAxesColorOrder');
test = Subject;
Group1 = [56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 105 106 108 109 110 111 116 118 120 121 122 123 124 125 126 127 132 ]; % HC 
Group2 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 104 107 112 113 114 115 117 119 128 129 130 131 133 134 135 136 137 138 139 140 141 142 ]; % DP 

YLIMITS   = [-0.9 1.2];
XLIMITS   = [-25 42]; 
LEG_POS   = [0.62, 0.05, 0.32, 0.18];   % unten rechts
FONT_SZ   = 8;
LEG_FS    = 6;

% --- Subplot-Konfiguration ---
subplotList = {
    lIFG,   'left VLPFC',  1;
    rIFG,   'right VLPFC', 2;
    lDLPFC, 'left DLPFC',  3;
    rDLPFC, 'right DLPFC', 4;
    SAC,    'SAC',         5;
};

% --- Farben fuer Gruppen ---
hexColor1 = '#00676f'; rgbColor1 = sscanf(hexColor1(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor2 = '#9b7b00'; rgbColor2 = sscanf(hexColor2(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor3 = '#b43602'; rgbColor3 = sscanf(hexColor3(2:end), '%2x%2x%2x', [1 3]) / 255; 

% --- Figure setup ---
close all
figure
set(gcf,'Units','inches','Position',[1 1 8.27 6])

% --- Zeitachse ---
timeOffset = 0;              % kein offset bei Export3
t = (-49:(size(Data.AvgCTL2,1)-50))'/10 + timeOffset; 
lh = cell(size(subplotList,1),1);

% --- Loop ueber alle Subplots ---
for iPlot = 1:size(subplotList,1)
    chn   = subplotList{iPlot,1};
    TITLE = subplotList{iPlot,2};
    spID  = subplotList{iPlot,3};
    subplot(3,2,spID)
    
    % --- Hintergrund-Patches ---
    p1 = patch([0 40 40 0], [-1 -1 2 2], [0.95 0.95 0.95], ...
         'EdgeColor','none','DisplayName','trial'); 
    hold on
    p2 = patch([-5 0 0 -5], [-1 -1 2 2], [0.85 0.85 0.85], ...
         'EdgeColor','none','DisplayName','baseline');

    % --- Gruppe 1: HC ---
    dat = squeeze(mean(Data.AvgCTL2(:,chn,Group1),2)); 
    SEM = std(dat,0,2) ./ sqrt(numel(Group1));         
    timeseries = mean(dat,2);                           
    h1 = plot(t,timeseries,'.-','Color',rgbColor1,'DisplayName','HC');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor1,'facealpha',0.15})

    % --- Gruppe 2: DP ---
    dat = squeeze(mean(Data.AvgCTL2(:,chn,Group2),2));
    SEM = std(dat,0,2) ./ sqrt(numel(Group2));
    timeseries = mean(dat,2);
    h2 = plot(t,timeseries,'.-','Color',rgbColor2,'DisplayName','DP');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor2,'facealpha',0.15})

    % --- Achsen, Labels, Titel ---
    ylim(YLIMITS)
    xlim(XLIMITS)
    xlabel('time in s','FontSize',FONT_SZ,'FontWeight','bold')
    ylabel('z','FontSize',FONT_SZ,'FontWeight','bold')
    title(TITLE,'FontSize',FONT_SZ,'FontWeight','bold')

    % --- Legende ---
    lh{iPlot} = legend([p1 p2 h1 h2],'trial','baseline','HC','DP');
    legend boxoff 
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)

    % --- weisser Hintergrund ---
    lh{iPlot} = legend([p1 p2 h1 h2],'trial','baseline','HC','DP');
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)
    set(lh{iPlot}, 'Color', 'w');       % Weisser Hintergrund
    set(lh{iPlot}, 'EdgeColor', 'w');   % Rahmen
    set(lh{iPlot}, 'Box', 'on');        % Kasten sichtbar
    hold off
end

filename = 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\FigureX_Timeseries_DPvsHC_CTL2_window3';
print(gcf, [filename '.svg'], '-dsvg', '-r600');
print(gcf, [filename '.jpg'], '-djpeg', '-r600');

%% Time series HC vs. DP all ROIs: TSST (Export 2)
clear all
clc
lIFG=[7 9 6];
lDLPFC=[10 12 11];
rIFG=[18 21 19];
rDLPFC=[20 23 24];
SAC=[27 26 25 28 30 31 32 35 36];
load('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\Data_Export2.mat');
load('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\Subjects_Export2.mat');

lineV       = @(x,spec) plot(repmat(x(:),1,2)',repmat(ylim,numel(x),1)',spec{:}); 
toPatch     = @(x1,x2,y1,y2,spec) patch([x1(:);flipud(repmat(x2(:),numel(x1)./numel(x2),1))],[y1(:);flipud(repmat(y2(:),numel(y1)./numel(y2),1))],spec{:}); 
colors = get(groot,'defaultAxesColorOrder');
test = Subject;
Group1 = [56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 105 106 108 109 110 111 116 118 120 121 122 123 124 125 126 127 132 ]; % HC 
Group2 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 104 107 112 113 114 115 117 119 128 129 130 131 133 134 135 136 137 138 139 140 141 142 ]; % DP 

YLIMITS   = [-0.9 1.2];
XLIMITS   = [-25 42];
LEG_POS   = [0.62, 0.05, 0.32, 0.18];   % unten rechts
FONT_SZ   = 8;
LEG_FS    = 6;

% --- Subplot-Konfiguration ---
subplotList = {
    lIFG,   'left VLPFC',  1;
    rIFG,   'right VLPFC', 2;
    lDLPFC, 'left DLPFC',  3;
    rDLPFC, 'right DLPFC', 4;
    SAC,    'SAC',         5;
};

% --- Farben fuer Gruppen ---
hexColor1 = '#00676f'; rgbColor1 = sscanf(hexColor1(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor2 = '#9b7b00'; rgbColor2 = sscanf(hexColor2(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor3 = '#b43602'; rgbColor3 = sscanf(hexColor3(2:end), '%2x%2x%2x', [1 3]) / 255; 

% --- Figure setup ---
close all
figure
set(gcf,'Units','inches','Position',[1 1 8.27 6])

% --- Zeitachse ---
timeOffset = -15;          % offset bei Export1 und Export2
t = (-49:(size(Data.AvgArith,1)-50))'/10 + timeOffset; 
lh = cell(size(subplotList,1),1);

% --- Loop ueber alle Subplots ---
for iPlot = 1:size(subplotList,1)
    chn   = subplotList{iPlot,1};
    TITLE = subplotList{iPlot,2};
    spID  = subplotList{iPlot,3};
    subplot(3,2,spID)
    
    % --- Hintergrund-Patches ---
    p1 = patch([0 40 40 0], [-1 -1 2 2], [0.95 0.95 0.95], ...
         'EdgeColor','none','DisplayName','trial'); 
    hold on
    p2 = patch([-20 -15 -15 -20], [-1 -1 2 2], [0.85 0.85 0.85], ...
        'EdgeColor','none','DisplayName','baseline');

    % --- Gruppe 1: HC ---
    dat = squeeze(mean(Data.AvgArith(:,chn,Group1),2)); 
    SEM = std(dat,0,2) ./ sqrt(numel(Group1));          
    timeseries = mean(dat,2);                           
    h1 = plot(t,timeseries,'.-','Color',rgbColor1,'DisplayName','HC');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor1,'facealpha',0.15})

    % --- Gruppe 2: DP ---
    dat = squeeze(mean(Data.AvgArith(:,chn,Group2),2));
    SEM = std(dat,0,2) ./ sqrt(numel(Group2));
    timeseries = mean(dat,2);
    h2 = plot(t,timeseries,'.-','Color',rgbColor2,'DisplayName','DP');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor2,'facealpha',0.15})

    % --- Achsen, Labels, Titel ---
    ylim(YLIMITS)
    xlim(XLIMITS)
    xlabel('time in s','FontSize',FONT_SZ,'FontWeight','bold')
    ylabel('z','FontSize',FONT_SZ,'FontWeight','bold')
    title(TITLE,'FontSize',FONT_SZ,'FontWeight','bold')

    % --- Legende ---
    lh{iPlot} = legend([p1 p2 h1 h2],'trial','baseline','HC','DP');
    legend boxoff 
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)

    % --- weisser Hintergrund ---
    lh{iPlot} = legend([p1 p2 h1 h2],'trial','baseline','HC','DP');
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)
    set(lh{iPlot}, 'Color', 'w');       % Weisser Hintergrund
    set(lh{iPlot}, 'EdgeColor', 'w');   % Rahmen
    set(lh{iPlot}, 'Box', 'on');        % Kasten sichtbar

    hold off
end

filename = 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\SupplementaryMaterial\FigureS6.2_Timeseries_DPvsHC_Arith_window2';
print(gcf, [filename '.svg'], '-dsvg', '-r600');
print(gcf, [filename '.jpg'], '-djpeg', '-r600');


%% Time series HC vs. DP all ROIs: CLT1 (Export 2)
lineV       = @(x,spec) plot(repmat(x(:),1,2)',repmat(ylim,numel(x),1)',spec{:}); 
toPatch     = @(x1,x2,y1,y2,spec) patch([x1(:);flipud(repmat(x2(:),numel(x1)./numel(x2),1))],[y1(:);flipud(repmat(y2(:),numel(y1)./numel(y2),1))],spec{:}); 
colors = get(groot,'defaultAxesColorOrder');
test = Subject;
Group1 = [56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 105 106 108 109 110 111 116 118 120 121 122 123 124 125 126 127 132 ]; % HC 
Group2 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 104 107 112 113 114 115 117 119 128 129 130 131 133 134 135 136 137 138 139 140 141 142 ]; % DP 

YLIMITS   = [-0.9 1.2];
XLIMITS   = [-25 42];
LEG_POS   = [0.62, 0.05, 0.32, 0.18];   % unten rechts
FONT_SZ   = 8;
LEG_FS    = 6;

% --- Subplot-Konfiguration ---
subplotList = {
    lIFG,   'left VLPFC',  1;
    rIFG,   'right VLPFC', 2;
    lDLPFC, 'left DLPFC',  3;
    rDLPFC, 'right DLPFC', 4;
    SAC,    'SAC',         5;
};

% --- Farben fuer Gruppen ---
hexColor1 = '#00676f'; rgbColor1 = sscanf(hexColor1(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor2 = '#9b7b00'; rgbColor2 = sscanf(hexColor2(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor3 = '#b43602'; rgbColor3 = sscanf(hexColor3(2:end), '%2x%2x%2x', [1 3]) / 255; 

% --- Figure setup ---
close all
figure
set(gcf,'Units','inches','Position',[1 1 8.27 6])

% --- Zeitachse ---
timeOffset = -15;          % offset bei Export1 und Export2
t = (-49:(size(Data.AvgCTL1,1)-50))'/10 + timeOffset; 
lh = cell(size(subplotList,1),1);

% --- Loop ueber alle Subplots ---
for iPlot = 1:size(subplotList,1)
    chn   = subplotList{iPlot,1};
    TITLE = subplotList{iPlot,2};
    spID  = subplotList{iPlot,3};
    subplot(3,2,spID)
    
    % --- Hintergrund-Patches ---
    p1 = patch([0 40 40 0], [-1 -1 2 2], [0.95 0.95 0.95], ...
         'EdgeColor','none','DisplayName','trial'); 
    hold on
    p2 = patch([-20 -15 -15 -20], [-1 -1 2 2], [0.85 0.85 0.85], ...
        'EdgeColor','none','DisplayName','baseline');

    % --- Gruppe 1: HC ---
    dat = squeeze(mean(Data.AvgCTL1(:,chn,Group1),2)); 
    SEM = std(dat,0,2) ./ sqrt(numel(Group1));          
    timeseries = mean(dat,2);                           
    h1 = plot(t,timeseries,'.-','Color',rgbColor1,'DisplayName','HC');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor1,'facealpha',0.15})

    % --- Gruppe 2: DP ---
    dat = squeeze(mean(Data.AvgCTL1(:,chn,Group2),2));
    SEM = std(dat,0,2) ./ sqrt(numel(Group2));
    timeseries = mean(dat,2);
    h2 = plot(t,timeseries,'.-','Color',rgbColor2,'DisplayName','DP');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor2,'facealpha',0.15})

    % --- Achsen, Labels, Titel ---
    ylim(YLIMITS)
    xlim(XLIMITS)
    xlabel('time in s','FontSize',FONT_SZ,'FontWeight','bold')
    ylabel('z','FontSize',FONT_SZ,'FontWeight','bold')
    title(TITLE,'FontSize',FONT_SZ,'FontWeight','bold')

    % --- Legende ---
    lh{iPlot} = legend([p1 p2 h1 h2],'trial','baseline','HC','DP');
    legend boxoff 
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)

    % --- weisser Hintergrund ---
    lh{iPlot} = legend([p1 p2 h1 h2],'trial','baseline','HC','DP');
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)
    set(lh{iPlot}, 'Color', 'w');       % Weisser Hintergrund
    set(lh{iPlot}, 'EdgeColor', 'w');   % Rahmen
    set(lh{iPlot}, 'Box', 'on');        % Kasten sichtbar

    hold off
end

filename = 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\FigureX_Timeseries_DPvsHC_CTL1_window2';
print(gcf, [filename '.svg'], '-dsvg', '-r600');
print(gcf, [filename '.jpg'], '-djpeg', '-r600');


%% Time series HC vs. DP all ROIs: CLT2 (Export 2)
lineV       = @(x,spec) plot(repmat(x(:),1,2)',repmat(ylim,numel(x),1)',spec{:}); 
toPatch     = @(x1,x2,y1,y2,spec) patch([x1(:);flipud(repmat(x2(:),numel(x1)./numel(x2),1))],[y1(:);flipud(repmat(y2(:),numel(y1)./numel(y2),1))],spec{:}); 
colors = get(groot,'defaultAxesColorOrder');
test = Subject;
Group1 = [56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 105 106 108 109 110 111 116 118 120 121 122 123 124 125 126 127 132 ]; % HC 
Group2 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 104 107 112 113 114 115 117 119 128 129 130 131 133 134 135 136 137 138 139 140 141 142 ]; % DP 

YLIMITS   = [-0.9 1.2];
XLIMITS   = [-25 42];
LEG_POS   = [0.62, 0.05, 0.32, 0.18];   % unten rechts
FONT_SZ   = 8;
LEG_FS    = 6;

% --- Subplot-Konfiguration ---
subplotList = {
    lIFG,   'left VLPFC',  1;
    rIFG,   'right VLPFC', 2;
    lDLPFC, 'left DLPFC',  3;
    rDLPFC, 'right DLPFC', 4;
    SAC,    'SAC',         5;
};

% --- Farben fuer Gruppen ---
hexColor1 = '#00676f'; rgbColor1 = sscanf(hexColor1(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor2 = '#9b7b00'; rgbColor2 = sscanf(hexColor2(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor3 = '#b43602'; rgbColor3 = sscanf(hexColor3(2:end), '%2x%2x%2x', [1 3]) / 255; 

% --- Figure setup ---
close all
figure
set(gcf,'Units','inches','Position',[1 1 8.27 6])

% --- Zeitachse ---
timeOffset = -15;          % offset bei Export1 und Export2
t = (-49:(size(Data.AvgCTL2,1)-50))'/10 + timeOffset; 
lh = cell(size(subplotList,1),1);

% --- Loop ueber alle Subplots ---
for iPlot = 1:size(subplotList,1)
    chn   = subplotList{iPlot,1};
    TITLE = subplotList{iPlot,2};
    spID  = subplotList{iPlot,3};
    subplot(3,2,spID)
    
    % --- Hintergrund-Patches ---
    p1 = patch([0 40 40 0], [-1 -1 2 2], [0.95 0.95 0.95], ...
         'EdgeColor','none','DisplayName','trial'); 
    hold on
    p2 = patch([-20 -15 -15 -20], [-1 -1 2 2], [0.85 0.85 0.85], ...
        'EdgeColor','none','DisplayName','baseline');

    % --- Gruppe 1: HC ---
    dat = squeeze(mean(Data.AvgCTL2(:,chn,Group1),2)); 
    SEM = std(dat,0,2) ./ sqrt(numel(Group1));          
    timeseries = mean(dat,2);                           
    h1 = plot(t,timeseries,'.-','Color',rgbColor1,'DisplayName','HC');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor1,'facealpha',0.15})

    % --- Gruppe 2: DP ---
    dat = squeeze(mean(Data.AvgCTL2(:,chn,Group2),2));
    SEM = std(dat,0,2) ./ sqrt(numel(Group2));
    timeseries = mean(dat,2);
    h2 = plot(t,timeseries,'.-','Color',rgbColor2,'DisplayName','DP');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor2,'facealpha',0.15})

    % --- Achsen, Labels, Titel ---
    ylim(YLIMITS)
    xlim(XLIMITS)
    xlabel('time in s','FontSize',FONT_SZ,'FontWeight','bold')
    ylabel('z','FontSize',FONT_SZ,'FontWeight','bold')
    title(TITLE,'FontSize',FONT_SZ,'FontWeight','bold')

    % --- Legende ---
    lh{iPlot} = legend([p1 p2 h1 h2],'trial','baseline','HC','DP');
    legend boxoff 
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)

    % --- weisser Hintergrund ---
    lh{iPlot} = legend([p1 p2 h1 h2],'trial','baseline','HC','DP');
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)
    set(lh{iPlot}, 'Color', 'w');       % Weisser Hintergrund
    set(lh{iPlot}, 'EdgeColor', 'w');   % Rahmen
    set(lh{iPlot}, 'Box', 'on');        % Kasten sichtbar

    hold off
end

filename = 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\FigureX_Timeseries_DPvsHC_CTL2_window2';
print(gcf, [filename '.svg'], '-dsvg', '-r600');
print(gcf, [filename '.jpg'], '-djpeg', '-r600');


%% Time series HC vs. DP all ROIs: TSST (Export 1)
clear all
clc
lIFG=[7 9 6];
lDLPFC=[10 12 11];
rIFG=[18 21 19];
rDLPFC=[20 23 24];
SAC=[27 26 25 28 30 31 32 35 36];
load('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\Data_Export1.mat');
load('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\Subjects_Export1.mat');

lineV       = @(x,spec) plot(repmat(x(:),1,2)',repmat(ylim,numel(x),1)',spec{:}); 
toPatch     = @(x1,x2,y1,y2,spec) patch([x1(:);flipud(repmat(x2(:),numel(x1)./numel(x2),1))],[y1(:);flipud(repmat(y2(:),numel(y1)./numel(y2),1))],spec{:}); 
colors = get(groot,'defaultAxesColorOrder');
test = Subject;
Group1 = [56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 105 106 108 109 110 111 116 118 120 121 122 123 124 125 126 127 132 ]; % HC 
Group2 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 104 107 112 113 114 115 117 119 128 129 130 131 133 134 135 136 137 138 139 140 141 142 ]; % DP 

YLIMITS   = [-0.9 1.2];
XLIMITS   = [-25 2]; 
LEG_POS   = [0.62, 0.05, 0.32, 0.18];   % unten rechts
FONT_SZ   = 8;
LEG_FS    = 6;

% --- Subplot-Konfiguration ---
subplotList = {
    lIFG,   'left VLPFC',  1;
    rIFG,   'right VLPFC', 2;
    lDLPFC, 'left DLPFC',  3;
    rDLPFC, 'right DLPFC', 4;
    SAC,    'SAC',         5;
};

% --- Farben fuer Gruppen ---
hexColor1 = '#00676f'; rgbColor1 = sscanf(hexColor1(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor2 = '#9b7b00'; rgbColor2 = sscanf(hexColor2(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor3 = '#b43602'; rgbColor3 = sscanf(hexColor3(2:end), '%2x%2x%2x', [1 3]) / 255; 

% --- Figure setup ---
close all
figure
set(gcf,'Units','inches','Position',[1 1 8.27 6])

% --- Zeitachse ---
timeOffset = -15;          % offset bei Export1 und Export2
t = (-49:(size(Data.AvgArith,1)-50))'/10 + timeOffset; 
lh = cell(size(subplotList,1),1);

% --- Loop ueber alle Subplots ---
for iPlot = 1:size(subplotList,1)
    chn   = subplotList{iPlot,1};
    TITLE = subplotList{iPlot,2};
    spID  = subplotList{iPlot,3};
    subplot(3,2,spID)
    
    % --- Hintergrund-Patches ---
    hold on
    p2 = patch([-20 -15 -15 -20], [-1 -1 2 2], [0.85 0.85 0.85], ...
        'EdgeColor','none','DisplayName','baseline');

    % --- Gruppe 1: HC ---
    dat = squeeze(mean(Data.AvgArith(:,chn,Group1),2)); 
    SEM = std(dat,0,2) ./ sqrt(numel(Group1));          
    timeseries = mean(dat,2);                           
    h1 = plot(t,timeseries,'.-','Color',rgbColor1,'DisplayName','HC');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor1,'facealpha',0.15})

    % --- Gruppe 2: DP ---
    dat = squeeze(mean(Data.AvgArith(:,chn,Group2),2));
    SEM = std(dat,0,2) ./ sqrt(numel(Group2));
    timeseries = mean(dat,2);
    h2 = plot(t,timeseries,'.-','Color',rgbColor2,'DisplayName','DP');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor2,'facealpha',0.15})

    % --- Achsen, Labels, Titel ---
    ylim(YLIMITS)
    xlim(XLIMITS)
    xlabel('time in s','FontSize',FONT_SZ,'FontWeight','bold')
    ylabel('z','FontSize',FONT_SZ,'FontWeight','bold')
    title(TITLE,'FontSize',FONT_SZ,'FontWeight','bold')

 % --- Legende ---
    lh{iPlot} = legend([p2 h1 h2],'baseline','HC','DP');
    legend boxoff 
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)

    % --- weisser Hintergrund ---
    lh{iPlot} = legend([p2 h1 h2],'baseline','HC','DP');
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)
    set(lh{iPlot}, 'Color', 'w');       % Weisser Hintergrund
    set(lh{iPlot}, 'EdgeColor', 'w');   % Rahmen
    set(lh{iPlot}, 'Box', 'on');        % Kasten sichtbar

    hold off
end

filename = 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\SupplementaryMaterial\FigureS6.1_Timeseries_DPvsHC_Arith_window1';
print(gcf, [filename '.svg'], '-dsvg', '-r600');
print(gcf, [filename '.jpg'], '-djpeg', '-r600');


%% Time series HC vs. DP all ROIs: CTL1 (Export 1)
lineV       = @(x,spec) plot(repmat(x(:),1,2)',repmat(ylim,numel(x),1)',spec{:}); 
toPatch     = @(x1,x2,y1,y2,spec) patch([x1(:);flipud(repmat(x2(:),numel(x1)./numel(x2),1))],[y1(:);flipud(repmat(y2(:),numel(y1)./numel(y2),1))],spec{:}); 
colors = get(groot,'defaultAxesColorOrder');
test = Subject;
Group1 = [56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 105 106 108 109 110 111 116 118 120 121 122 123 124 125 126 127 132 ]; % HC 
Group2 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 104 107 112 113 114 115 117 119 128 129 130 131 133 134 135 136 137 138 139 140 141 142 ]; % DP 

YLIMITS   = [-0.9 1.2];
XLIMITS   = [-25 2]; 
LEG_POS   = [0.62, 0.05, 0.32, 0.18];   % unten rechts
FONT_SZ   = 8;
LEG_FS    = 6;

% --- Subplot-Konfiguration ---
subplotList = {
    lIFG,   'left VLPFC',  1;
    rIFG,   'right VLPFC', 2;
    lDLPFC, 'left DLPFC',  3;
    rDLPFC, 'right DLPFC', 4;
    SAC,    'SAC',         5;
};

% --- Farben fuer Gruppen ---
hexColor1 = '#00676f'; rgbColor1 = sscanf(hexColor1(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor2 = '#9b7b00'; rgbColor2 = sscanf(hexColor2(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor3 = '#b43602'; rgbColor3 = sscanf(hexColor3(2:end), '%2x%2x%2x', [1 3]) / 255; 

% --- Figure setup ---
close all
figure
set(gcf,'Units','inches','Position',[1 1 8.27 6])

% --- Zeitachse ---
timeOffset = -15;          % offset bei Export1 und Export2
t = (-49:(size(Data.AvgCTL1,1)-50))'/10 + timeOffset; 
lh = cell(size(subplotList,1),1);

% --- Loop ueber alle Subplots ---
for iPlot = 1:size(subplotList,1)
    chn   = subplotList{iPlot,1};
    TITLE = subplotList{iPlot,2};
    spID  = subplotList{iPlot,3};
    subplot(3,2,spID)
    
    % --- Hintergrund-Patches ---
    hold on
    p2 = patch([-20 -15 -15 -20], [-1 -1 2 2], [0.85 0.85 0.85], ...
        'EdgeColor','none','DisplayName','baseline');

    % --- Gruppe 1: HC ---
    dat = squeeze(mean(Data.AvgCTL1(:,chn,Group1),2)); 
    SEM = std(dat,0,2) ./ sqrt(numel(Group1));          
    timeseries = mean(dat,2);                           
    h1 = plot(t,timeseries,'.-','Color',rgbColor1,'DisplayName','HC');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor1,'facealpha',0.15})

    % --- Gruppe 2: DP ---
    dat = squeeze(mean(Data.AvgCTL1(:,chn,Group2),2));
    SEM = std(dat,0,2) ./ sqrt(numel(Group2));
    timeseries = mean(dat,2);
    h2 = plot(t,timeseries,'.-','Color',rgbColor2,'DisplayName','DP');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor2,'facealpha',0.15})

    % --- Achsen, Labels, Titel ---
    ylim(YLIMITS)
    xlim(XLIMITS)
    xlabel('time in s','FontSize',FONT_SZ,'FontWeight','bold')
    ylabel('z','FontSize',FONT_SZ,'FontWeight','bold')
    title(TITLE,'FontSize',FONT_SZ,'FontWeight','bold')

 % --- Legende ---
    lh{iPlot} = legend([p2 h1 h2],'baseline','HC','DP');
    legend boxoff 
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)

    % --- weisser Hintergrund ---
    lh{iPlot} = legend([p2 h1 h2],'baseline','HC','DP');
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)
    set(lh{iPlot}, 'Color', 'w');       % Weisser Hintergrund
    set(lh{iPlot}, 'EdgeColor', 'w');   % Rahmen
    set(lh{iPlot}, 'Box', 'on');        % Kasten sichtbar

    hold off
end

filename = 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\FigureX_Timeseries_DPvsHC_CTL1_window1';
print(gcf, [filename '.svg'], '-dsvg', '-r600');
print(gcf, [filename '.jpg'], '-djpeg', '-r600');

%% Time series HC vs. DP all ROIs: CTL2 (Export 1)
lineV       = @(x,spec) plot(repmat(x(:),1,2)',repmat(ylim,numel(x),1)',spec{:}); 
toPatch     = @(x1,x2,y1,y2,spec) patch([x1(:);flipud(repmat(x2(:),numel(x1)./numel(x2),1))],[y1(:);flipud(repmat(y2(:),numel(y1)./numel(y2),1))],spec{:}); 
colors = get(groot,'defaultAxesColorOrder');
test = Subject;
Group1 = [56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 105 106 108 109 110 111 116 118 120 121 122 123 124 125 126 127 132 ]; % HC 
Group2 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 104 107 112 113 114 115 117 119 128 129 130 131 133 134 135 136 137 138 139 140 141 142 ]; % DP 

YLIMITS   = [-0.9 1.2];
XLIMITS   = [-25 2]; 
LEG_POS   = [0.62, 0.05, 0.32, 0.18];   % unten rechts
FONT_SZ   = 8;
LEG_FS    = 6;

% --- Subplot-Konfiguration ---
subplotList = {
    lIFG,   'left VLPFC',  1;
    rIFG,   'right VLPFC', 2;
    lDLPFC, 'left DLPFC',  3;
    rDLPFC, 'right DLPFC', 4;
    SAC,    'SAC',         5;
};

% --- Farben fuer Gruppen ---
hexColor1 = '#00676f'; rgbColor1 = sscanf(hexColor1(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor2 = '#9b7b00'; rgbColor2 = sscanf(hexColor2(2:end), '%2x%2x%2x', [1 3]) / 255; 
hexColor3 = '#b43602'; rgbColor3 = sscanf(hexColor3(2:end), '%2x%2x%2x', [1 3]) / 255; 

% --- Figure setup ---
close all
figure
set(gcf,'Units','inches','Position',[1 1 8.27 6])

% --- Zeitachse ---
timeOffset = -15;          % offset bei Export1 und Export2
t = (-49:(size(Data.AvgCTL2,1)-50))'/10 + timeOffset; 
lh = cell(size(subplotList,1),1);

% --- Loop ueber alle Subplots ---
for iPlot = 1:size(subplotList,1)
    chn   = subplotList{iPlot,1};
    TITLE = subplotList{iPlot,2};
    spID  = subplotList{iPlot,3};
    subplot(3,2,spID)
    
    % --- Hintergrund-Patches ---
    hold on
    p2 = patch([-20 -15 -15 -20], [-1 -1 2 2], [0.85 0.85 0.85], ...
        'EdgeColor','none','DisplayName','baseline');

    % --- Gruppe 1: HC ---
    dat = squeeze(mean(Data.AvgCTL2(:,chn,Group1),2)); 
    SEM = std(dat,0,2) ./ sqrt(numel(Group1));          
    timeseries = mean(dat,2);                           
    h1 = plot(t,timeseries,'.-','Color',rgbColor1,'DisplayName','HC');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor1,'facealpha',0.15})

    % --- Gruppe 2: DP ---
    dat = squeeze(mean(Data.AvgCTL2(:,chn,Group2),2));
    SEM = std(dat,0,2) ./ sqrt(numel(Group2));
    timeseries = mean(dat,2);
    h2 = plot(t,timeseries,'.-','Color',rgbColor2,'DisplayName','DP');
    toPatch(t,t,timeseries-SEM,timeseries+SEM,{rgbColor2,'facealpha',0.15})

    % --- Achsen, Labels, Titel ---
    ylim(YLIMITS)
    xlim(XLIMITS)
    xlabel('time in s','FontSize',FONT_SZ,'FontWeight','bold')
    ylabel('z','FontSize',FONT_SZ,'FontWeight','bold')
    title(TITLE,'FontSize',FONT_SZ,'FontWeight','bold')

 % --- Legende ---
    lh{iPlot} = legend([p2 h1 h2],'baseline','HC','DP');
    legend boxoff 
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)

    % --- weisser Hintergrund ---
    lh{iPlot} = legend([p2 h1 h2],'baseline','HC','DP');
    set(lh{iPlot},'FontSize',LEG_FS,'FontWeight','bold')
    set(lh{iPlot},'Units','normalized','Position',LEG_POS)
    set(lh{iPlot}, 'Color', 'w');       % Weisser Hintergrund
    set(lh{iPlot}, 'EdgeColor', 'w');   % Rahmen
    set(lh{iPlot}, 'Box', 'on');        % Kasten sichtbar

    hold off
end

filename = 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\FigureX_Timeseries_DPvsHC_CTL2_window1';
print(gcf, [filename '.svg'], '-dsvg', '-r600');
print(gcf, [filename '.jpg'], '-djpeg', '-r600');



%% Brainmaps CTL1 CTL2 und TSST contrast 
close all
clear all
clc
initroutines('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\routines\2017-04-27')                    
clear settings P PS;
P = NirsPlotTool();

settings.experiment.time_series{1} = {'name','CTL1.cui','sample_rate',10,'trigger_name','CTL1.trigger'};
settings.experiment.time_series{2} = {'name','CTL2.cui','sample_rate',10,'trigger_name','CTL2.trigger'};
settings.experiment.time_series{3} = {'name','Arith.cui','sample_rate',10,'trigger_name','Stress.trigger'};

% settings.experiment.category{1} = {'name','TriggerA','trigger_token',1}; % for analysis of window 3
settings.experiment.category{1} = {'name','TriggerA','trigger_token',9}; % for analysis of window 1 and window 2

P = P.setProperties(settings);   
P = NirsPlotTool();
P = P.setProperty('show_probeset','on');
P = P.setProperties(settings);

PS = NirsProbeset('brain_coord_file','Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Studie Stress Rumination\Koords\NIRS-probesetXYZ_Alle2.txt');
settings.plot_tool.probesets{1} = {'name','Gesamt','probeset',PS};

P = P.setProperties(settings);
P = P.setProperty('probesets',{'name','Gesamt','probeset',PS});

P = P.setProperties(settings);   

P = P.setProperty('show_probeset','on');
P = P.setProperties(settings);


lIFG=[7 9 6];
lDLPFC=[10 12 11];
rIFG=[18 21 19];
rDLPFC=[20 23 24];
SAC=[27 26 25 28 30 31 32 35 36];
% load('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\Data_Export1.mat');
% load('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\Subjects_Export1.mat');
load('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\Data_Export3.mat');
load('Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\Subjects_Export3.mat');

Group2 = [56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 105 106 108 109 110 111 116 118 120 121 122 123 124 125 126 127 132 ]; % HC 
Group1 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 104 107 112 113 114 115 117 119 128 129 130 131 133 134 135 136 137 138 139 140 141 142 ]; % DP 

T1=((mean(Data.AmpCTL1( :,Group1),2)')-(mean(Data.AmpCTL1( :,Group2),2)'))./(sqrt((var(Data.AmpCTL1( :,Group2)')+var(Data.AmpCTL1( :,Group1)'))/2))
T2=((mean(Data.AmpCTL2( :,Group1),2)')-(mean(Data.AmpCTL2( :,Group2),2)'))./(sqrt((var(Data.AmpCTL2( :,Group2)')+var(Data.AmpCTL2( :,Group1)'))/2))
T3=((mean(Data.AmpArith(:,Group1),2)')-(mean(Data.AmpArith(:,Group2),2)'))./(sqrt((var(Data.AmpArith(:,Group2)')+var(Data.AmpArith(:,Group1)'))/2))

P = P.setProperty('show_probeset','on'); % "Zahlen-Channelbezeichnungen" werden rausgenommen
P = P.setProperty('show_head','on','map_type','brain_map','color_map','braincmap','color_limit',[-0.5 0.5],'color_gap',[],'view_angles',{[180 30],[-90 0],[90 0],[0 30];[180 30],[-90 0],[90 0],[0 30];[180 30],[-90 0],[90 0],[0 30]},'column_names',{'frontal','left','right','parietal'},'row_names',{'CTL1','CTL2','TSST'},'show_colorbar','d');
P = P.setProperty('values2map',{{T1},{T1},{T1},{T1};{T2},{T2},{T2},{T2};{T3},{T3},{T3},{T3}}...
                ,'probesets2map',{{'Gesamt'},{'Gesamt'},{'Gesamt'},{'Gesamt'};{'Gesamt'},{'Gesamt'},{'Gesamt'},{'Gesamt'};{'Gesamt'},{'Gesamt'},{'Gesamt'},{'Gesamt'}});
P = P.map('values');

% filename = 'Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST Anticipation\Auswertung\Plots\Figure6_Brainmap_window1';
% print(gcf, [filename '.svg'], '-dsvg', '-r600');
% print(gcf, [filename '.jpg'], '-djpeg', '-r600');
