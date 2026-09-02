resource "aws_route53_zone" "main" {
  name    = var.domain
  comment = "HostedZone created by Route53 Registrar"
}

# Apex A + AAAA → CloudFront alias
resource "aws_route53_record" "apex_a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "apex_aaaa" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain
  type    = "AAAA"
  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}

# www A + AAAA → CloudFront alias
resource "aws_route53_record" "www_a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.domain}"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_aaaa" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.domain}"
  type    = "AAAA"
  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}

# ACM DNS validation CNAMEs — must be preserved for automatic cert renewal
resource "aws_route53_record" "acm_validation_apex_1" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "_781ab460a2114680546b56456a9a7106.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = ["_7f56e3e23528fa5778927669315d883b.jsxlrrpjwm.acm-validations.aws."]
}

resource "aws_route53_record" "acm_validation_apex_2" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "_a8223b3c38860c4d3d786de9ac06447a.${var.domain}"
  type    = "CNAME"
  ttl     = 500
  records = ["_a40d05521de06272d5f47ad68480c054.npyrrzfbbp.acm-validations.aws."]
}

resource "aws_route53_record" "acm_validation_www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "_b7d5479979587ee499168ad52dd0c2e9.www.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = ["_2cfd969320fde17b0e672fbda3336bf9.mhbtsbpdnt.acm-validations.aws."]
}

# devbox → Tailscale IPv4 (100.104.241.57). 100.64.0.0/10 is the CGNAT range
# Tailscale hands out; the record only resolves to a routable host for
# tailnet members. Supersedes the wildcard *.brooks-security.com catch-all.
resource "aws_route53_record" "devbox_a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "devbox.${var.domain}"
  type    = "A"
  ttl     = 300
  records = ["100.104.241.57"]
}

# seedbox (formerly sarah) → Tailscale IPv4 (100.113.78.51). Same CGNAT
# semantics as devbox_a: routable only for tailnet members.
resource "aws_route53_record" "seedbox_a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "seedbox.${var.domain}"
  type    = "A"
  ttl     = 300
  records = ["100.113.78.51"]
}

# hermes (Hermes dashboard) → Tailscale IPv4 (100.113.78.51), same box as
# seedbox (moved from devbox 2026-08-30). Served as
# https://hermes.brooks-security.com by Caddy on seedbox,
# which terminates TLS via Let's Encrypt DNS-01 (Route 53 plugin) — no
# public reachability required. Supersedes the wildcard catch-all.
resource "aws_route53_record" "hermes_a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "hermes.${var.domain}"
  type    = "A"
  ttl     = 300
  records = ["100.113.78.51"]
}

# webui (Hermes WebUI — nesquena/hermes-webui) → Tailscale IPv4
# (100.113.78.51), same box as seedbox/hermes. Served as
# https://webui.brooks-security.com by Caddy on seedbox (LE DNS-01 cert,
# caddy-dns/route53) — tailnet-only, same CGNAT semantics as hermes_a.
# Upstream is the hermes-webui systemd unit bound to loopback :8787.
resource "aws_route53_record" "webui_a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "webui.${var.domain}"
  type    = "A"
  ttl     = 300
  records = ["100.113.78.51"]
}

# plex (Plex Media Server) → Tailscale IPv4 (100.104.241.57), same box as
# devbox. Served as https://plex.brooks-security.com by Caddy on devbox
# (LE DNS-01 cert, caddy-dns/route53) — tailnet-only, same CGNAT semantics
# as devbox_a / hermes_a. Supersedes the wildcard catch-all.
resource "aws_route53_record" "plex_a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "plex.${var.domain}"
  type    = "A"
  ttl     = 300
  records = ["100.104.241.57"]
}

# dnd (hardcore-rpg game atlas) → Tailscale IPv4 (100.113.78.51), same box as
# seedbox. Served as https://dnd.brooks-security.com by Caddy on seedbox (LE
# DNS-01 cert, caddy-dns/route53) — tailnet-only, same CGNAT semantics as
# seedbox_a / hermes_a. Moved devbox -> seedbox 2026-09-02 (devbox retired).
resource "aws_route53_record" "dnd_a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dnd.${var.domain}"
  type    = "A"
  ttl     = 300
  records = ["100.113.78.51"]
}
