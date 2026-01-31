# sing-box Configuration Rulesets

This directory contains sing-box configuration files and rulesets managed by chezmoi.

## Files

### Main Configuration
- `sing-box.json.tmpl` - Main sing-box configuration (template)

### Rulesets

#### Cloudflare IP Routing (Auto-updated)
- `sing-box-cloudflare-ip-ruleset.json.tmpl` - **Dynamic template** that fetches Cloudflare IP ranges (IPv4 + IPv6) from official Cloudflare API on every `chezmoi apply`

**Purpose:** Routes all Cloudflare CDN traffic through proxy to bypass country-level blocking

#### Domain & IP Routing (Manual)
- `sing-box-domain-ruleset.json` - Domains to route through proxy (includes Cloudflare-owned domains like cloudflare.com, workers.dev, etc.)
- `sing-box-ip-ruleset.json` - Custom IP ranges to route through proxy

## How Cloudflare IP Auto-Update Works

The `sing-box-cloudflare-ip-ruleset.json.tmpl` template uses chezmoi's `output` function to execute:
```
curl -s https://www.cloudflare.com/ips-v4
curl -s https://www.cloudflare.com/ips-v6
```

The template then combines both lists and converts them to proper JSON format using the `toJson` function.

**Note:** Internet connectivity is required during `chezmoi apply` to fetch the latest IP ranges.

## Adding Domains/IPs

To add domains or IPs to route through the proxy:

1. **For domains:** Edit `sing-box-domain-ruleset.json` and add to the `domain_suffix` array (sorted alphabetically)
2. **For IPs:** Edit `sing-box-ip-ruleset.json` and add to the `ip_cidr` array

**Note:** Cloudflare-owned domains (cloudflare.com, workers.dev, pages.dev, warp.plus, one.one.one.one, etc.) are already included in the main domain ruleset. Cloudflare IP ranges are automatically fetched and don't need manual management.

## Applying Changes

After modifying any ruleset:

```bash
# Preview changes
chezmoi diff

# Apply changes
chezmoi apply

# Restart sing-box (if running)
# macOS:
brew services restart sing-box
# Linux:
sudo systemctl restart sing-box
```

## Order of Routing Rules

In `sing-box.json.tmpl`, rules are evaluated in order:

1. DNS hijacking
2. **Proxy domains** (includes Cloudflare domains) → proxy
3. **Cloudflare IPs** (auto-fetched) → proxy
4. Custom proxy IPs → proxy
5. Process-specific rules (Discord, Telegram, etc.) → proxy
6. Everything else → direct

This ensures Cloudflare traffic (both domains and IPs) is routed through proxy.
