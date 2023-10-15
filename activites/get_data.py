import pyrfume
import pandas as pd

# leffingwell
pyrfume.set_data_path('leffingwell')

behavior = pyrfume.load_data('leffingwell/behavior_sparse.csv')
pyrfume.save_data(behavior, 'behavior_sparse.csv')

behavior = pyrfume.load_data('leffingwell/stimuli.csv')
pyrfume.save_data(behavior, 'stimuli.csv')

# goodscents
pyrfume.set_data_path('goodscents')

behavior = pyrfume.load_data('goodscents/behavior.csv')
pyrfume.save_data(behavior, 'behavior.csv')

behavior = pyrfume.load_data('goodscents/stimuli.csv')
pyrfume.save_data(behavior, 'stimuli.csv')

behavior = pyrfume.load_data('goodscents/molecules.csv')
pyrfume.save_data(behavior, 'molecules.csv')
