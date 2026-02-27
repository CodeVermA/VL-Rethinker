
benchmark=mathvista
if  [[ "$benchmark" == "m3u" ]]; then 
    export testdata="./data/MMMUPro_full.parquet"
elif  [[ "$benchmark" == "m3u_val" ]]; then 
    export testdata="./data/m3u_val.parquet"
elif [[ "$benchmark" == "emma" ]]; then 
    export factor=4
    export testdata="./data/emma_full.parquet"
elif [[ "$benchmark" == "mathverse" ]]; then 
    export testdata="./data/MathVerse_testmini.parquet"
elif [[ "$benchmark" == "mathvista" ]]; then 
    export testdata="./data/VL-Rethinker/data/testmini-00000-of-00001-725687bf7a18d64b.parquet"
elif [[ "$benchmark" == "mathvision" ]]; then 
    export testdata="./data/MathVision_test3040.parquet"
else 
    export testdata="./data/${benchmark}.parquet"
fi 

export num_vllm=1
export num_gpus=1
export tagname=eval_debug_${benchmark}
export policy="/home/s2412780/MLP-CW3/VL-Rethinker/model_cache"
export nvj_path=""
export working_dir="/home/s2412780/MLP-CW3/VL-Rethinker"

ls /home/s2412780/MLP-CW3/VL-Rethinker/model_cache
nvidia-smi

bash ./scripts/eval_vlm_new.sh

