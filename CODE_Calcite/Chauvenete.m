
% clear
% Data_input=input

Mydata_matrix_new=Mydata_matrix;


LLL=length(Mydata_matrix_new(1,:,1));

Number_images=length(Mydata_matrix(:,1,1));

for mmm=1:Number_images

    
    for mmm2=1:Number_images
        
         
         Mydata_matrix_unrolled_dumb= Mydata_matrix_new(mmm2,:,:);
         Mydata_matrix_unrolled_dumb=Mydata_matrix_unrolled_dumb(:);
         
         Mydata_matrix_unrolled(mmm2,:)=Mydata_matrix_unrolled_dumb;
    
    end
    
   
    mydata_in=Mydata_matrix_unrolled(mmm,:);

    ll_size=size(mydata_in);

    ll_size1=ll_size(1);
    ll_size2=ll_size(2);

    Data_input=mydata_in(:);

    if general_outliers==1

        av=mean(Data_input);
        stnd=std(Data_input);
        L=size(Data_input,1);
        tst = icdf('normal', exclude_number_distribution,0,1);  %1-1/(4*L)
        tst_data=(Data_input-av)/stnd;
        [RR,C]=find(abs(tst_data)>tst);

        [II,S]=find(abs(tst_data)<tst);

        excluded=Data_input(RR);
        included_d=Data_input(II);
        Data_input(RR)=mean(included_d);
        
        included_d_matrix=Mydata_matrix_unrolled(:,II);
        
        for mmm2=1:Number_images 
            
            Mydata_matrix_unrolled(mmm2,RR)=mean(included_d_matrix(mmm2, :));

        end
        
        if iterate_more_than_once_outliers==1

            while isempty(excluded)~=1

                av=mean(Data_input);
                stnd=std(Data_input);
                L=size(Data_input,1);
                tst = icdf('normal', exclude_number_distribution,0,1);  %1-1/(4*L)
                tst_data=(Data_input-av)/stnd;
                [RR,C]=find(abs(tst_data)>tst);

                [II,S]=find(abs(tst_data)<tst);

                excluded=Data_input(RR);
                included_d=Data_input(II);
                Data_input(RR)=mean(included_d);

                included_d_matrix=Mydata_matrix_unrolled(:,II);

                for mmm2=1:Number_images 

                    Mydata_matrix_unrolled(mmm2,RR)=mean(included_d_matrix(mmm2, :));

                end
            end     
        end
    end



    initial_value_remove=1;

    if moving_outliers_detector==1 


        final_value_remove=initial_value_remove+grouped_data_Fts_MODEL_2-1;

        if general_outliers==1
            DATA_SET_RAW_dumb=Mydata_matrix_unrolled(mmm, :);
    %         mydata_in_dummy=DATA_SET_RAW_dumb;
        else
            DATA_SET_RAW_dumb=mydata_in(:);
    %         mydata_in_dummy=DATA_SET_RAW_dumb;
        end

        length_Data_input_ALL=length(DATA_SET_RAW_dumb);

        iteration_clean=floor(length_Data_input_ALL/grouped_data_Fts_MODEL_2);   % Number of iterations 
        DATA_SET_RAW_dumb=DATA_SET_RAW_dumb(1:(grouped_data_Fts_MODEL_2*iteration_clean));

        initial_value_remove=1;
        time_cleaning=tic;

        New_vector_out_adding=[];
        New_vector_out_adding_ALL=[];

        for i_t=1:iteration_clean



            final_value_remove=initial_value_remove+grouped_data_Fts_MODEL_2-1;
            Data_input=DATA_SET_RAW_dumb(initial_value_remove:final_value_remove);
            New_vector_out_adding=Mydata_matrix_unrolled(:,initial_value_remove:final_value_remove);
             
             
            %%% First round of cleaning 
            av=mean(Data_input);
            stnd=std(Data_input);
            %%test
            L=size(Data_input,1);   

            tst = icdf('normal', exclude_number_distribution_local,0,1);  %1-1/(4*L)
            tst_data=(Data_input-av)/stnd;

            [RR,C]=find(abs(tst_data)>tst);
            [II,S]=find(abs(tst_data)<tst);

            excluded=Data_input(RR);
            included_d=Data_input(II);

            Data_input(RR)=mean(included_d);
            
            
            included_d_matrix=[];
            included_d_matrix=New_vector_out_adding(:,II);

            for mmm2=1:Number_images 

                New_vector_out_adding(mmm2,RR)=mean(included_d_matrix(mmm2, :));

            end

            %%%% enf first round %%%%
            if iterate_more_than_once_outliers==1

                while isempty(excluded)~=1

                    av=mean(Data_input);
                    stnd=std(Data_input);
                    %%test
                    L=size(Data_input,1);   

                    tst = icdf('normal', exclude_number_distribution,0,1);  %1-1/(4*L)
                    tst_data=(Data_input-av)/stnd;
                    [RR,C]=find(abs(tst_data)>tst);
                    [II,S]=find(abs(tst_data)<tst);

                    excluded=Data_input(RR);
                    included_d=Data_input(II);

                    Data_input(RR)=mean(included_d);
                    
                    included_d_matrix=[];
                    included_d_matrix=New_vector_out_adding(:,II);

                    for mmm2=1:Number_images 

                        New_vector_out_adding(mmm2,RR)=mean(included_d_matrix(mmm2, :));

                    end

                end
            end

            New_vector_out_adding_ALL=[New_vector_out_adding_ALL, New_vector_out_adding];
            initial_value_remove=final_value_remove+1;

        end

        
        New_vector_out_adding_ALL_dumb3=New_vector_out_adding_ALL(:);    
        Mydata_matrix_new=reshape(New_vector_out_adding_ALL_dumb3, Number_images, LLL, LLL);
       
        time_to_clean=toc(time_cleaning);

    else
        Mydata_matrix_new=[];
        
        Mydata_matrix_new=reshape(Mydata_matrix_unrolled(:), Number_images, LLL, LLL);
    end
end 


Mydata_matrix=[];
Mydata_matrix=Mydata_matrix_new;
    