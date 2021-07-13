from djongo import models


class Generic(models.Model):
    generic_name = models.CharField(max_length=32)

    class Meta:
        abstract = True

    def __str__(self):
        return self.generic_name


class Brand(models.Model):
    brand_name = models.CharField(max_length=32)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    dosage = models.CharField(max_length=4)
    generic = models.EmbeddedField(model_container=Generic)

    def __str__(self):
        return self.brand_name
