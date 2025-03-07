# Generated by Django 5.1.4 on 2025-02-20 16:40

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0009_category_shopitem_category'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='shopitem',
            name='category',
        ),
        migrations.RemoveField(
            model_name='rating',
            name='ShopItem',
        ),
        migrations.AddField(
            model_name='shopitem',
            name='rating',
            field=models.IntegerField(blank=True, null=True, validators=[django.core.validators.MinValueValidator(0), django.core.validators.MaxValueValidator(5)]),
        ),
        migrations.AddField(
            model_name='shopitem',
            name='visit_count',
            field=models.IntegerField(default=0),
        ),
        migrations.DeleteModel(
            name='Category',
        ),
        migrations.DeleteModel(
            name='Rating',
        ),
    ]
