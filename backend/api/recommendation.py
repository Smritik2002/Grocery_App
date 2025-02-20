import pandas as pd
import numpy as np
from api.models import ShopItem


def cosine_similarity_manual(matrix):
    matrix = matrix.T
    num_items = matrix.shape[0]

    similarity_matrix = np.zeros((num_items, num_items))

    for i in range(num_items):
        for j in range(num_items):
            dot_product = np.dot(matrix[i], matrix[j])
            norm_i = np.linalg.norm(matrix[i])
            norm_j = np.linalg.norm(matrix[j])

            if norm_i == 0 or norm_j == 0:
                similarity_matrix[i][j] = 0
            else:
                similarity_matrix[i][j] = dot_product / (norm_i * norm_j)

    return similarity_matrix


def recommend_items(item_id, num_recommendations=5):
    df, user_item_matrix = load_and_process_data()

    if df is None:
        return []

    item_similarity = cosine_similarity_manual(user_item_matrix.values)

    item_sim_df = pd.DataFrame(item_similarity, index=user_item_matrix.columns, columns=user_item_matrix.columns)

    if item_id not in item_sim_df.index:
        return []

    similar_items = item_sim_df[item_id].sort_values(ascending=False)[1:num_recommendations+1]

    item_names = ShopItem.objects.filter(id__in=similar_items.index).values("id", "name")

    return [{"id": item["id"], "name": item["name"], "similarity": round(similar_items[item["id"]], 6)} for item in item_names]
