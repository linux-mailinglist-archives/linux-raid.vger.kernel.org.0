Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC27123B4C
	for <lists+linux-raid@lfdr.de>; Wed, 18 Dec 2019 01:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfLRAGd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 19:06:33 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43741 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRAGd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 19:06:33 -0500
Received: by mail-qt1-f193.google.com with SMTP id b3so431856qti.10
        for <linux-raid@vger.kernel.org>; Tue, 17 Dec 2019 16:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VkGcvc5TNw38lli7sxu81ijtcIs3UdVuzjWK11li4As=;
        b=p5+ooaHUneKULnaui3tN6EjCrtuW3bYRXkk5XUYXznMXcbwNUmoVRG+o0kpECMjknA
         5iF1Xe+c718YkM6kyHNpBDTu90vzWUImQfsQ0rvDKU/oqK0Wf9HprFIM04Q/ZDGIJpfo
         IyFLkJjBQ3WuVzSLKJS8Hjwc/xDFnYwsh+Souae8/J7CYR8JFRz4fvB0oM6JLqS4tDFL
         ao2+9USOwI1Mns1O2VTFOyuKBPJsEtUDgM52IW5PQa6psAxUtd4M+Qoh2q0mtMsgA8Cr
         sqEbUjGIJx2cRbxExbyVr9q8Tk38I2B2go/4nsSho7fjUkDtj/lrHrrHtUhUesKYbhZa
         eGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VkGcvc5TNw38lli7sxu81ijtcIs3UdVuzjWK11li4As=;
        b=S3usQdD0GA9O9WgYxqIM8Kb4dIlWyGgWPfj1Cq+ssoheun5csKWzLQ3z2L9iEbBR6b
         SvKdJue+CMbUTRxMb7/MocM/DpQzvtAyivkxEkqv5vQOdyC30qL5KZTAknqrvUN/fryz
         k1dgvtbq7emFVDVAizz0PrDXgXGCJY3ffjHTdrJm49Vp8u6k0KgV2dAGxz/7IeXsGWae
         vlTryV+9c1eszVZFRgGQ/e9t/knpLAhQ7VCaxBFe8aCMns2noQzZ8nUET+40Rv7qmbvj
         1BSn4p2hYxSzrtPk50Ba85/xl42MdRgM1K0ES2YKTMaC9rBDYvNF0wN1rxHU6twawCha
         SOkA==
X-Gm-Message-State: APjAAAXB9y/ZQUpBrCxdZOntNkXSmZ+eNv+lzWUGtXqPjG6ta7yHV5Ex
        CeCnFOKekIsfJHPlqstm5QT5uQ1tWb83a1y6pzuB6tQW
X-Google-Smtp-Source: APXvYqwP8Pqq4EB64/p0S7a4yOdOvWhHBp7ivbFbW3DtepFTeMWlvS+VZD+Ap5asCy5Q0PKNYu+mGXOYxl64zBbTQk0=
X-Received: by 2002:ac8:330d:: with SMTP id t13mr533262qta.379.1576627592039;
 Tue, 17 Dec 2019 16:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com> <20191121103728.18919-4-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20191121103728.18919-4-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 17 Dec 2019 16:06:21 -0800
Message-ID: <CAPhsuW7OYyCbdidYVKjhYqs09WKvgOMny-QXDwnkhbebs+ZT1A@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] md: add serialize_policy sysfs node for raid1
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Nov 21, 2019 at 2:37 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> With the new sysfs node, we can use it to control if raid1 array
> wants io serialization or not. So mddev_create_serial_pool and
> mddev_destroy_serial_pool are called in serialize_policy_store
> to enable or disable the serialization.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

I added:

diff --git i/drivers/md/md.c w/drivers/md/md.c
index efeaeba3583d..5a2bb6bcc43d 100644
--- i/drivers/md/md.c
+++ w/drivers/md/md.c
@@ -5330,6 +5330,9 @@ serialize_policy_store(struct mddev *mddev,
const char *buf, size_t len)
        if (value == mddev->serialize_policy)
                return len;

+       if (value < 0 || value > 1)
+               return -EINVAL;
+
        err = mddev_lock(mddev);
        if (err)
                return err;
