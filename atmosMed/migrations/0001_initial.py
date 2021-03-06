# Generated by Django 3.2.5 on 2021-07-13 05:38

import atmosMed.models
from django.db import migrations, models
import djongo.models.fields


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Brand',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('brand_name', models.CharField(max_length=32)),
                ('price', models.DecimalField(decimal_places=2, max_digits=10)),
                ('dosage', models.CharField(max_length=4)),
                ('generic', djongo.models.fields.EmbeddedField(model_container=atmosMed.models.Generic)),
            ],
        ),
    ]
