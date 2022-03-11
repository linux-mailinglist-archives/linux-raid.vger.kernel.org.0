Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E694D67A2
	for <lists+linux-raid@lfdr.de>; Fri, 11 Mar 2022 18:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350778AbiCKRbu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 11 Mar 2022 12:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiCKRbt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 11 Mar 2022 12:31:49 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBF6C2E61
        for <linux-raid@vger.kernel.org>; Fri, 11 Mar 2022 09:30:46 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id k25so10820862iok.8
        for <linux-raid@vger.kernel.org>; Fri, 11 Mar 2022 09:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXWf3I0xCujxLu8bDz7q+9+6F+4g6AyNkKp3SeHhzQU=;
        b=Gw0hXQsoHkv9ZTjG/cWtnt4/GhK687iHDGX4SHp9exn7x/089wn4x5rmPdgD7+c7+b
         eCDqKZpfNMMcuQzAajePs5PghSpYARbXnHLYcU9CeyqQbWlZqfi4ICd8aCUncygzzSxm
         6jQ69tZnHKzmhg28HdUIlrPyh2NhX1DqAg2jSB07pso631qy9i6vrOHMaoA43hACPOKT
         jDKg06rZ0WwhQMDva91IgkPH2f4XHy3UbOIoEReRnwyyA3yYfE/nlISMEF+zvKLqITl5
         9ica4pLaVGUOESqsSqX2lvQGWtBIrZSuoCNvaoS7DUUtYukweDbOf2IQuypDrJgA5lC7
         v45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXWf3I0xCujxLu8bDz7q+9+6F+4g6AyNkKp3SeHhzQU=;
        b=KlqsP2y181P1by7LI5aDZARZEF8b6VSLyD3rkztss+z6Tul1a9gJhxSGFhu0VLRjVy
         N0cYvBQPZH69qu1/TYGEQyKABC+sqi8KvGT3vx1hMERszkMJF04qJXrdh/ISsILlUMPg
         attNUlQvooQ0md8MAFikXH5nxClwJeQBeT9sGlbmUdVwP56kHbX86URGBuO9cdmmluPu
         TfdlGwhw9nepzDfbC4Wp37dsZbb7w54asmarl01LZsRpEt4RWVg+7sqdf/qoqtjKXGab
         hCwEf7+bQ7z1I8xbaTklu9+tv07z3VzYAd86cDfkL/QMgEAwkxzY/rsbc2DoavJvmQvS
         w1TQ==
X-Gm-Message-State: AOAM531UzyFlF9HuPhDSXBJKBDl2wFml0Jnx/9b2Kupis+Zf8n/LFMDP
        myFABjfX+a86BOzJvSbNmOk3lw==
X-Google-Smtp-Source: ABdhPJw6RkyEEarUKe3MuVgm7RweWmu0f/TyIsSTGawK16k+fDCI1QxenS7OBmHoUWt8ZgyqFtuhAA==
X-Received: by 2002:a05:6602:2c52:b0:646:2488:a9a0 with SMTP id x18-20020a0566022c5200b006462488a9a0mr9005491iov.130.1647019845634;
        Fri, 11 Mar 2022 09:30:45 -0800 (PST)
Received: from m1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r2-20020a92d442000000b002c62b540c85sm4622356ilm.5.2022.03.11.09.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:30:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        llowrey@nuclearwinter.com, i400sjon@gmail.com,
        rogerheflin@gmail.com
Subject: [PATCHSET 0/2] Fix raid rebuild performance regression
Date:   Fri, 11 Mar 2022 10:30:39 -0700
Message-Id: <20220311173041.165948-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

This should fix the reported RAID rebuild regression, while also
providing better performance for other workloads particularly on
rotating storage.

-- 
Jens Axboe


