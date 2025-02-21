from api.models import ShopItem  # Replace 'myapp' with your actual app name
import os
import csv
import pandas as pd
import numpy as np


class GroceryRecommendationSystem:
    def __init__(self):
        self.shopitems_df = pd.read_csv("E:/Grocery_App/backend/data/shopitems.csv")
        self.profiles_df = pd.read_csv("E:/Grocery_App/backend/data/profiles.csv")
        self.user_item_matrix = self.create_user_item_matrix()
        self.user_similarity_df = self.compute_user_similarity()
        self.item_similarity_df = self.compute_item_similarity()
        self.item_content_similarity_df = self.compute_content_similarity()
        self.hybrid_similarity_df = self.compute_hybrid_similarity()

    def create_user_item_matrix(self):
        return pd.pivot_table(self.shopitems_df, values="Visit Count", index="ID", columns="ItemName", fill_value=0)

    def cosine_similarity_manual(self, matrix):
        norm_matrix = np.linalg.norm(matrix, axis=1, keepdims=True)
        normalized_matrix = matrix / (norm_matrix + 1e-10)
        return np.dot(normalized_matrix, normalized_matrix.T)

    def compute_user_similarity(self):
        user_similarity = self.cosine_similarity_manual(self.user_item_matrix.values)
        return pd.DataFrame(user_similarity, index=self.user_item_matrix.index, columns=self.user_item_matrix.index)

    def compute_item_similarity(self):
        item_similarity = self.cosine_similarity_manual(self.user_item_matrix.T.values)
        return pd.DataFrame(item_similarity, index=self.user_item_matrix.columns, columns=self.user_item_matrix.columns)

    def compute_content_similarity(self):
        descriptions = self.shopitems_df['Description'].astype(str).fillna("")
        term_frequency = {}

        for desc in descriptions:
            words = desc.lower().split()
            for word in words:
                term_frequency[word] = term_frequency.get(word, 0) + 1

        vectors = []
        for desc in descriptions:
            words = desc.lower().split()
            vector = np.array([term_frequency[word] for word in words if word in term_frequency])
            vectors.append(np.pad(vector, (0, max(0, len(term_frequency) - len(vector))), 'constant'))

        item_content_similarity = self.cosine_similarity_manual(np.array(vectors))
        return pd.DataFrame(
            item_content_similarity, index=self.shopitems_df['ItemName'],
            columns=self.shopitems_df['ItemName'])

    def compute_hybrid_similarity(self):
        return pd.DataFrame((0.5 * self.item_similarity_df.values) + (0.5 * self.item_content_similarity_df.values),
                            index=self.shopitems_df['ItemName'], columns=self.shopitems_df['ItemName'])

    def recommend_items_for_user(self, user_id, top_n=5):
        if user_id not in self.user_similarity_df.index:
            return []
        similar_users = self.user_similarity_df[user_id].sort_values(ascending=False)[1:top_n+1]
        recommended_items = self.user_item_matrix.loc[similar_users.index].mean().sort_values(ascending=False)[:top_n]
        return list(zip(recommended_items.index.tolist(), recommended_items.values.tolist()))

    def recommend_similar_items(self, item_name, top_n=5):
        if item_name not in self.item_similarity_df.index:
            return []
        recommended_items = self.item_similarity_df[item_name].sort_values(ascending=False)[1:top_n]
        return list(zip(recommended_items.index.tolist(), recommended_items.values.tolist()))

    def hybrid_recommend_items(self, item_name, top_n=5):
        if item_name not in self.hybrid_similarity_df.index:
            return []
        recommended_items = self.hybrid_similarity_df[item_name].sort_values(ascending=False)[1:top_n]
        return list(zip(recommended_items.index.tolist(), recommended_items.values.tolist()))


# # Example usage
# grocery_recommender = GroceryRecommendationSystem(
#     "/home/mango/django/Grocery_App/backend/data/fruits_vegetables_dataset.csv",
#     "/home/mango/django/Grocery_App/backend/data/profiles.csv"
# )

# user_id = 1
# item_name = "Banana"
# print("User-based Recommendations:", grocery_recommender.recommend_items_for_user(user_id))
# print("Item-based Recommendations:", grocery_recommender.recommend_similar_items(item_name))
# print("Hybrid Recommendations:", grocery_recommender.hybrid_recommend_items(item_name))


# def import_vegetables_from_csv(csv_file):
#     if not os.path.exists(csv_file):
#         print('File not found. Please provide a valid CSV file path.')
#         return

#     with open(csv_file, newline='', encoding='utf-8') as file:
#         reader = csv.DictReader(file)
#         for row in reader:
#             try:
#                 ShopItem.objects.create(
#                     name=row['ItemName'],
#                     price=float(row['Price ($)']),
#                     color=row['Color'],
#                     description=row['Description'],
#                     rating=float(row['Rating']) if row['Rating'] else None,
#                     visit_count=int(row['Visit Count']) if 'Visit Count' in row else 0
#                 )
#             except Exception as e:
#                 print(f"Error adding {row['name']}: {e}")

#     print('CSV data import completed.')


# import_vegetables_from_csv("/home/mango/django/Grocery_App/backend/data/fruits_vegetables_dataset.csv")
