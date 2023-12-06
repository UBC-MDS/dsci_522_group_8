all : notebooks/_build/html/index.html

data/raw/bank.zip: scripts/download_data.py
	python scripts/download_data.py \
        --url='https://archive.ics.uci.edu/static/public/222/bank+marketing.zip' \
        --write_to='data/raw'

data/raw/bank: scripts/unzip.py data/raw/bank.zip
    python scripts/unzip.py \
        --path_to_zip_file='data/raw/bank.zip' \
        --directory_to_extract_to='data/raw/bank'

data/processed/train_df.csv data/processed/test_df.csv : scripts/train_test_split.py data/raw/bank/bank-full.csv
    python scripts/train_test_split.py \
        --raw-data='data/raw/bank/bank-full.csv' \
        --data-to='data/processed' \
        --seed=522

results/_build/html/index.html : notebooks/bank_analysis.ipynb \
report/_toc.yml \
report/_config.yml \
	jupyter-book build report

clean :
	rm -rf report/_build