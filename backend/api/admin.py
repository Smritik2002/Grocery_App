import csv
from django.http import HttpResponse
from django.contrib import admin
from .models import ShopItem, Profile

# CSV Export for ShopItem


def export_shopitems_to_csv(modeladmin, request, queryset):
    """Export selected ShopItems as a CSV file."""
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename=shopitems.csv'

    writer = csv.writer(response)
    writer.writerow(['ID', 'Name', 'Price', 'Color', 'Description', 'Rating', 'Visit Count'])

    for item in queryset:
        writer.writerow([item.id, item.name, item.price, item.color, item.description, item.rating, item.visit_count])

    return response


export_shopitems_to_csv.short_description = "Export selected ShopItems as CSV"

# CSV Export for Profile


def export_profiles_to_csv(modeladmin, request, queryset):
    """Export selected Profiles along with user data as a CSV file."""
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename=profiles.csv'

    writer = csv.writer(response)
    writer.writerow(['User ID', 'Username', 'Email', 'Age', 'Interest'])

    for profile in queryset:
        writer.writerow([profile.user.id, profile.user.username, profile.user.email, profile.age, profile.interest])

    return response


export_profiles_to_csv.short_description = "Export selected Profiles as CSV"


@admin.register(ShopItem)
class ShopItemAdmin(admin.ModelAdmin):
    list_display = ('name', 'price', 'color', 'rating', 'visit_count')
    search_fields = ('name', 'color', 'description')
    list_filter = ('rating', 'price')
    actions = [export_shopitems_to_csv]  # Add CSV export action


@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'age', 'interest')
    search_fields = ('user__username', 'interest')
    actions = [export_profiles_to_csv]  # Add CSV export action
