
for part in ensemble_train ensemble_validate test; do 
    CUDA_VISIBLE_DEVICES=0 python inference-pre-ensemble.py \
	      --output_dir="/Youtube-8M/model_predictions/${part}/distillchain_video_dcc" \
        --model_checkpoint_path="../model/distillchain_video_dcc/model.ckpt-19296" \
	      --input_data_pattern="/Youtube-8M/data/video/${part}/*.tfrecord" \
	      --frame_features=False \
	      --feature_names="mean_rgb,mean_audio" \
	      --feature_sizes="1024,128" \
        --distill_data_pattern="/Youtube-8M/model_predictions/${part}/distillation/ensemble_mean_model/*.tfrecord" \
        --distillation_features=True \
        --distillation_as_input=True \
        --model=DistillchainDeepCombineChainModel \
        --moe_num_mixtures=4 \
        --deep_chain_layers=4 \
        --deep_chain_relu_cells=256 \
	      --batch_size=1024 \
	      --file_size=4096
done
