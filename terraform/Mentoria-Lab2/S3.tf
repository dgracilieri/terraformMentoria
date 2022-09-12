# Creación de bucket para los logs del sitio web estatico
resource "aws_s3_bucket" "c2bucketlog" {
  bucket = "s3-cloudops-bucket-webapp.carancas.com.logs"
  acl    = "log-delivery-write"
  force_destroy = true
 
  versioning {
    enabled = false
  }

  tags = merge({Name = join("-",tolist(["S3bucketlog", var.marca, var.environment]))},local.tags)

}

# Creación de bucket para el sitio web estatico
resource "aws_s3_bucket" "c2bucket" {
  bucket = "s3-cloudops-bucket-webapp.carancas.com"
  acl    = "private"
 
  versioning {
    enabled = false
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  logging {
    target_bucket = aws_s3_bucket.c2bucketlog.id
    target_prefix = "logs/"
  }

  tags = merge({Name = join("-",tolist(["S3bucket", var.marca, var.environment]))},local.tags)

}

#Sube archivos de tu sitio web estático
resource "aws_s3_bucket_object" "html" {
  for_each = fileset("./website-content/", "**/*.html")

  bucket = aws_s3_bucket.c2bucket.bucket
  key    = each.value
  source = "./website-content/${each.value}"
  etag   = filemd5("./website-content/${each.value}")
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "images" {
  for_each = fileset("./website-content/", "**/*.png")

  bucket = aws_s3_bucket.c2bucket.bucket
  key    = each.value
  source = "./website-content/${each.value}"
  etag   = filemd5("./website-content/${each.value}")
  content_type = "image/png"
}






# Creación de bucket para scripts
resource "aws_s3_bucket" "c2bucket_files" {
  bucket = "s3-cloudops-bucket-webapp.carancas.com-files"
  acl    = "private"
 
  versioning {
    enabled = false
  }

  tags = merge({Name = join("-",tolist(["S3bucket-Files", var.marca, var.environment]))},local.tags)

}

#Sube archivos de tu sitio web estático
resource "aws_s3_bucket_object" "script" {
  for_each = fileset("./website-content/", "**/*.sh")

  bucket = aws_s3_bucket.c2bucket_files.bucket
  key    = each.value
  source = "./website-content/${each.value}"
  etag   = filemd5("./website-content/${each.value}")
}


# --------------------------------------------------------------------------
# Agregue más aws_s3_bucket_object para el tipo de archivos que desea cargar
# La razón para tener múltiples aws_s3_bucket_object con tipo de archivo es asegurarse
# agregamos el tipo de contenido correcto para el archivo en S3. 
# De lo contrario, la carga del sitio web puede tener problemas, por ejemplo:


#resource "aws_s3_bucket_object" "svg" {
#  for_each = fileset("../../mywebsite/", "**/*.svg")
#
#  bucket = aws_s3_bucket.c2bucket.bucket
#  key    = each.value
#  source = "../../mywebsite/${each.value}"
#  etag   = filemd5("../../mywebsite/${each.value}")
#  content_type = "image/svg+xml"
#}
#
#resource "aws_s3_bucket_object" "css" {
#  for_each = fileset("../../mywebsite/", "**/*.css")
#
#  bucket = aws_s3_bucket.c2bucket.bucket
#  key    = each.value
#  source = "../../mywebsite/${each.value}"
#  etag   = filemd5("../../mywebsite/${each.value}")
#  content_type = "text/css"
#}
#
#resource "aws_s3_bucket_object" "js" {
#  for_each = fileset("../../mywebsite/", "**/*.js")
#
#  bucket = aws_s3_bucket.c2bucket.bucket
#  key    = each.value
#  source = "../../mywebsite/${each.value}"
#  etag   = filemd5("../../mywebsite/${each.value}")
#  content_type = "application/javascript"
#}
#
#resource "aws_s3_bucket_object" "json" {
#  for_each = fileset("../../mywebsite/", "**/*.json")
#
#  bucket = aws_s3_bucket.c2bucket.bucket
#  key    = each.value
#  source = "../../mywebsite/${each.value}"
#  etag   = filemd5("../../mywebsite/${each.value}")
#  content_type = "application/json"
#}
