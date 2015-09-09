
% clear
% Data_input=input


ll_size=size(mydata_in);

ll_size1=ll_size(1);
ll_size2=ll_size(2);

Data_input=mydata_in(:);
mydata_in_dummy=Data_input;

if general_outliers==1
    
    av=mean(Data_input);
    stnd=std(Data_input);
    L=size(Data_input,1);
    tst = icdf('normal', exclude_number_distribution_single,0,1);  %1-1/(4*L)
    tst_data=(Data_input-av)/stnd;
    [RR,C]=find(abs(tst_data)>tst);
    
    [II,S]=find(abs(tst_data)<tst);

    excluded=Data_input(RR);
    included_d=Data_input(II);
    Data_input(RR)=mean(included_d);

    if iterate_more_than_once_outliers==1

        while isempty(excluded)~=1
            
            av=mean(Data_input);
            stnd=std(Data_input);
            L=size(Data_input,1);
            tst = icdf('normal', exclude_number_distribution_single,0,1);  %1-1/(4*L)
            tst_data=(Data_input-av)/stnd;
            [RR,C]=find(abs(tst_data)>tst);

            [II,S]=find(abs(tst_data)<tst);

            excluded=Data_input(RR);
            included_d=Data_input(II);
            Data_input(RR)=mean(included_d);

        end     
    end
    mydata_out=reshape(Data_input, ll_size1, ll_size2);
end



RR_Matrix_MODEL_2=[];  
RR_excluded_MODEL_2=[];

initial_value_remove=1;

if moving_outliers_detector==1 


    final_value_remove=initial_value_remove+grouped_data_Fts_MODEL_2-1;
     
    if general_outliers==1
        DATA_SET_RAW_dumb=mydata_out(:);
%         mydata_in_dummy=DATA_SET_RAW_dumb;
    else
        DATA_SET_RAW_dumb=mydata_in(:);
%         mydata_in_dummy=DATA_SET_RAW_dumb;
    end

    length_Data_input_ALL=length(DATA_SET_RAW_dumb);

    iteration_clean=floor(length_Data_input_ALL/grouped_data_Fts_MODEL_2);   % Number of iterations 
    DATA_SET_RAW_dumb=DATA_SET_RAW_dumb(1:(grouped_data_Fts_MODEL_2*iteration_clean));

    RR_Matrix_MODEL_2=[];  
    RR_excluded_MODEL_2=[];

    initial_value_remove=1;
    time_cleaning=tic;
    
    New_vector_out_adding=[];
    
    for i_t=1:iteration_clean



        final_value_remove=initial_value_remove+grouped_data_Fts_MODEL_2-1;
        Data_input=DATA_SET_RAW_dumb(initial_value_remove:final_value_remove);
        
        %%% First round of cleaning 
        av=mean(Data_input);
        stnd=std(Data_input);
        %%test
        L=size(Data_input,1);   
        
        tst = icdf('normal', exclude_number_distribution_single,0,1);  %1-1/(4*L)
        tst_data=(Data_input-av)/stnd;
        
        [RR,C]=find(abs(tst_data)>tst);
        [II,S]=find(abs(tst_data)<tst);
    
        excluded=Data_input(RR);
        included_d=Data_input(II);

        Data_input(RR)=mean(included_d);

        %%%% enf first round %%%%
        if iterate_more_than_once_outliers==1
            
            while isempty(excluded)~=1

                av=mean(Data_input);
                stnd=std(Data_input);
                %%test
                L=size(Data_input,1);   

                tst = icdf('normal', exclude_number_distribution_single,0,1);  %1-1/(4*L)
                tst_data=(Data_input-av)/stnd;
                [RR,C]=find(abs(tst_data)>tst);
                [II,S]=find(abs(tst_data)<tst);
    
                excluded=Data_input(RR);
                included_d=Data_input(II);

                Data_input(RR)=mean(included_d);

            end
        end
        
        New_vector_out_adding=[New_vector_out_adding; Data_input];
        
        initial_value_remove=final_value_remove+1;

    end
  
    mydata_out=reshape(New_vector_out_adding, ll_size1, ll_size2);
    
    time_to_clean=toc(time_cleaning);

end
    
    