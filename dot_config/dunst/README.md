# Dunst Configuration

Notification daemon for desktop notifications.

## Files

- `dunstrc` - Notification appearance, behavior, and actions

## Features

- Customizable notification layout
- Urgency-based colors
- Click actions
- Keyboard shortcuts
- Material You theming integration

## Reload

```bash
dunstctl reload
```

Or it reloads automatically via chezmoi post-apply hook.

## Testing

Use `test-notifications.sh` script to test notification appearance.
