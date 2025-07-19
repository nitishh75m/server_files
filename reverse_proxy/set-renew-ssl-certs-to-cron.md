# Steps

1. Run: 
    ```
    crontab -e
    ```

2. Add This Cron Job (Runs Daily at 2:30 AM)
    ```
    30 2 * * * certbot renew --quiet --deploy-hook "docker restart nginx_reverse_proxy"
    ```

3. Test it Manually First
    ```
    sudo certbot renew --dry-run --deploy-hook "docker restart nginx_reverse_proxy"
    ```